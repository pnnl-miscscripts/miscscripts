%global _enable_debug_package 0
%global debug_package %{nil}
%global __os_install_post /usr/lib/rpm/brp-compress %{nil}
Summary: ContainerD and friends
Name: containerd
Version: @VERSION@
Release: 2
License: APL
Packager: MISCSCRIPTS
Group: Development/Tools

Source0: https://storage.googleapis.com/cri-containerd-release/cri-containerd-%{version}.linux-amd64.tar.gz
Source1: https://storage.googleapis.com/cri-containerd-release/cri-containerd-%{version}.linux-amd64.tar.gz.sha256

Requires: container-selinux
%{?systemd_requires}
BuildRequires: systemd
BuildRequires: coreutils

%description
%{summary}

%prep
echo "$(cat %{SOURCE1}) %{SOURCE0}" | sha256sum --check
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
/usr/local/bin/containerd-shim-runc-v2
/usr/local/bin/crictl
/usr/local/bin/ctr
/usr/local/bin/critest
/usr/local/bin/containerd
/usr/local/bin/containerd-shim
/usr/local/sbin/runc
/etc/systemd/system/containerd.service
/etc/crictl.yaml

%post
%systemd_post containerd.service

%preun
%systemd_preun containerd.service

%postun
%systemd_postun_with_restart containerd.service
