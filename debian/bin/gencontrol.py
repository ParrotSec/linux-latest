#!/usr/bin/env python3

import sys
sys.path.append(sys.argv[1] + "/lib/python")

from debian_linux.config import ConfigCoreDump
from debian_linux.debian import Changelog, PackageDescription, VersionLinux
from debian_linux.gencontrol import Gencontrol as Base
from debian_linux.utils import Templates

import os.path, re, codecs

class Gencontrol(Base):
    def __init__(self, config):
        super(Gencontrol, self).__init__(ConfigCoreDump(fp = open(config, "rb")), Templates(["debian/templates"]))

        config_entry = self.config['version',]
        self.version = VersionLinux(config_entry['source'])
        self.abiname = config_entry['abiname']
        self.vars = {
            'upstreamversion': self.version.linux_upstream,
            'version': self.version.linux_version,
            'source_upstream': self.version.upstream,
            'abiname': self.abiname,
        }

        changelog_version = Changelog()[0].version
        self.package_version = '%s+%s' % (self.version.linux_version, changelog_version.complete)

    def do_main_setup(self, vars, makeflags, extra):
        makeflags['GENCONTROL_ARGS'] = '-v%s' % self.package_version

        # A line will be appended to this for each image-dbg package.
        # Start with an empty file.
        open('debian/source.lintian-overrides', 'w').close()

    def do_main_packages(self, packages, vars, makeflags, extra):
        packages['source']['Build-Depends'].extend(
            ['linux-support-%s' % self.abiname,
             # We don't need this installed, but it ensures that after an
             # ABI bump linux is auto-built before linux-latest on each
             # architecture.
             'linux-headers-%s-all' % self.abiname]
        )

        latest_source = self.templates["control.source.latest"]
        packages.extend(self.process_packages(latest_source, vars))

        latest_doc = self.templates["control.doc.latest"]
        packages.extend(self.process_packages(latest_doc, vars))

        latest_tools = self.templates["control.tools.latest"]
        packages.extend(self.process_packages(latest_tools, vars))

    def do_flavour_packages(self, packages, makefile, arch, featureset, flavour, vars, makeflags, extra):
        if self.version.linux_modifier is None:
            try:
                vars['abiname'] = '-%s' % self.config['abi', arch]['abiname']
            except KeyError:
                vars['abiname'] = self.abiname
            makeflags['ABINAME'] = vars['abiname']

        config_base = self.config.merge('base', arch, featureset, flavour)
        config_description = self.config.merge('description', arch, featureset, flavour)
        config_image = self.config.merge('image', arch, featureset, flavour)

        vars['flavour'] = vars['localversion'][1:]
        vars['class'] = config_description['hardware']
        vars['longclass'] = config_description.get('hardware-long') or vars['class']

        templates = []

        def substitute_file(template, target, append=False):
            with codecs.open(target, 'a' if append else 'w',
                             'utf-8') as f:
                f.write(self.substitute(self.templates[template], vars))
        templates.extend(self.templates["control.image.latest.type-standalone"])
        templates.extend(self.templates["control.headers.latest"])
        if self.config.get_merge('build', arch, featureset, flavour,
                                 'debug-info', False):
            makeflags['DEBUG'] = True
            templates.extend(self.templates["control.image-dbg.latest"])
            substitute_file('lintian-overrides.image-dbg',
                            'debian/linux-image-%s-dbgsym.lintian-overrides' %
                            vars['flavour'])
            substitute_file('lintian-overrides.source',
                            'debian/source.lintian-overrides',
                            append=True)

        image_fields = {'Description': PackageDescription()}

        desc_parts = self.config.get_merge('description', arch, featureset, flavour, 'parts')
        if desc_parts:
            # XXX: Workaround, we need to support multiple entries of the same name
            parts = list(set(desc_parts))
            parts.sort()
            desc = image_fields['Description']
            for part in parts:
                desc.append(config_description['part-long-' + part])
                desc.append_short(config_description.get('part-short-' + part, ''))

            if self.config.merge('xen', arch, featureset, flavour):
                templates.extend(self.templates["control.xen-linux-system.latest"])

        packages_flavour = []

        packages_flavour.append(self.process_real_image(templates[0], image_fields, vars))
        packages_flavour.extend(self.process_packages(templates[1:], vars))

        for package in packages_flavour:
            name = package['Package']
            if name in packages:
                package = packages.get(name)
                package['Architecture'].add(arch)
            else:
                package['Architecture'] = arch
                packages.append(package)

        makeflags['GENCONTROL_ARGS'] = '-v%s' % self.package_version

        cmds_binary_arch = []
        for i in packages_flavour:
            cmds_binary_arch += self.get_link_commands(i, ['NEWS'])
        cmds_binary_arch += ["$(MAKE) -f debian/rules.real install-flavour %s" %
                             makeflags]
        makefile.add('binary-arch_%s_%s_%s_real' % (arch, featureset, flavour), cmds = cmds_binary_arch)

        # linux-image meta-packages include a bug presubj message
        # directing reporters to the real image package.
        bug_presubj = self.substitute(
            self.templates["bug-presubj.image.latest"], vars)
        codecs.open("debian/%s.bug-presubj" % packages_flavour[0]['Package'], 'w', 'utf-8').write(bug_presubj)

    def do_extra(self, packages, makefile):
        templates_extra = self.templates["control.extra"]

        packages.extend(self.process_packages(templates_extra, {}))
        extra_arches = {}
        for package in templates_extra:
            arches = package['Architecture']
            for arch in arches:
                i = extra_arches.get(arch, [])
                i.append(package)
                extra_arches[arch] = i
        archs = sorted(extra_arches.keys())
        for arch in archs:
            if arch == 'all':
                arch_var = ''
                target = 'binary-indep'
            else:
                arch_var = "ARCH='%s'" % arch
                target = 'binary-arch_%s' % arch
            cmds = []
            for i in extra_arches[arch]:
                if 'X-Version-Overwrite-Epoch' in i:
                    version = '-v1:%s' % self.package_version
                else:
                    version = '-v%s' % self.package_version
                cmds += self.get_link_commands(i, ['config', 'postinst', 'templates'])
                cmds.append("$(MAKE) -f debian/rules.real install-dummy %s DH_OPTIONS='-p%s' GENCONTROL_ARGS='%s'" % (arch_var, i['Package'], version))
            makefile.add(target, [target + '_extra'])
            makefile.add(target + '_extra', cmds = cmds)

    def process_real_image(self, entry, fields, vars):
        entry = self.process_package(entry, vars)
        for key, value in fields.items():
            if key in entry:
                real = entry[key]
                real.extend(value)
            elif value:
                entry[key] = value
        return entry

    @staticmethod
    def get_link_commands(package, names):
        cmds = []
        for name in names:
            match = re.match(r'^(linux-\w+)(-.*)$', package['Package'])
            if not match:
                continue
            source = 'debian/%s.%s' % (match.group(1), name)
            dest = 'debian/%s.%s' % (package['Package'], name)
            if (os.path.isfile(source) and
                (not os.path.isfile(dest) or os.path.islink(dest))):
                cmds.append('ln -sf %s %s' %
                            (os.path.relpath(source, 'debian'), dest))
        return cmds

if __name__ == '__main__':
    Gencontrol(sys.argv[1] + "/config.defines.dump")()
