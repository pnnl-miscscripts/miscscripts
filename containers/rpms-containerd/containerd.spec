%global _enable_debug_package 0
%global debug_package %{nil}
%global __os_install_post /usr/lib/rpm/brp-compress %{nil}
Summary: ContainerD and friends
Name: containerd
Version: @VERSION@
Release: 1
License: APL
Packager: MISCSCRIPTS
Group: Development/Tools
Source: containerd.tar.gz

%description
%{summary}

%prep
%setup -c

%build
echo nothing to build

%install
mkdir -p %{buildroot}
cp -a etc usr %{buildroot}
ls -l %{buildroot}

%files
/usr/local/bin/containerd-stress
/usr/local/bin/containerd-shim-runc-v1
/usr/local/bin/crictl
/usr/local/bin/ctr
/usr/local/bin/critest
/usr/local/bin/containerd
/usr/local/bin/containerd-shim
/usr/local/sbin/runc
/etc/systemd/system/containerd.service
/etc/crictl.yaml

