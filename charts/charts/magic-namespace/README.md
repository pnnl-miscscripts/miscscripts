# Magic Namespace

**Magic Namespace** provides an easy, comprehensive option for cluster operators
to manage namespaces and observe good security practices in _multi-tenant,
RBAC-enabled_ Kubernetes clusters.

## Introduction

So you've got a multi-tenant cluster? Let's assume your cluster is RBAC-enabled.
If it isn't, _go fix that first_. You're playing with fire. Until you fix that,
you don't need Magic Namespace. Go fix it. We'll wait...

In a multi-tenant cluster, a cluster operator (someone with full, unrestricted
privileges across the entire cluster), will manage users, groups, service
accounts, roles, and user/group bindings to roles-- all to either permit or
prevent subjects from performing certain actions in different namespaces.

A common paradigm that has emerged is that _teams_ are given their own namespace
and some degree of latitude to administer that namespace, whilst not being
permitted to perform actions on _other teams'_ namespaces.

Magic Namespace takes the pain out of this setup. It offers cluster operators an
easy, comprehensive avenue for using helm to manage namespaces, service
accounts, and role bindings for their consituent teams. Magic Namespace permits
cluster operators to manage all of this using familiar Helm-based workflows.

## How it Works

Magic Namespace offers cluster operators to define additional service accounts
and role bindings for use within the namespace. _Typically, it would be a good
idea to define at least one role binding that grants a user or group
administrative privileges in the namespace.

## Prerequisites

- A Kubernetes cluster with RBAC enabled

## Installing the Chart

To install the chart to create the `foo` namespace (if it doesn't already exist)
and useful resources (Tiller, service accounts, etc.) within that namespace:

```bash
$ helm install stable/magic-namespace --name foo --namespace foo
```

Typically, you will want to bind at least one user or group to the `admin` role
in this namespace. Here are steps to follow:

First, make a copy of the default `values.yaml`:

```bash
$ helm inspect values stable/magic-namespace > ~/my-values.yaml
```

Edit `~/my-values.yaml` accordingly. Here is a sample role binding:

```
...

roleBindings:
- name: admin-group-admin
  role:
    ## Valid values are "Role" or "ClusterRole"
    kind: ClusterRole
    name: admin
  subject:
    ## Valid values are "User", "Group", or "ServiceAccount"
    kind: Group
    name: <group>

...
```

Deploy as follows:

```bash
$ helm install stable/magic-namespace \
  --name foo \
  --namespace foo \
  --values ~/my-values.yaml
```

## Uninstalling the Chart

Deleting a release of a Magic Namespace will _not_ delete the namespace,
unless you have used the optional ```namespace``` setting. It will
only delete service accounts, role bindings, etc. from that
namespace. This is actually desirable behavior, as anything the team has
deployed within that namespace is likely to be unaffected, though further
deployments to and management of that namespace will not be possible by anyone
other than the cluster operator.

If you have used the ```namespace``` setting, deleting the release will cleanup
the namespace.

## Configuration

The following table lists the most common, useful, and interesting configuration
parameters of the Magic Namespace chart and their default values. Please
reference the default `values.yaml` to understand further options.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `serviceAccounts` | An optional array of names of additional service account to create | `nil` |
| `roleBindings` | An optional array of objects that define role bindings | `nil` |
| `roleBindings[n].role.kind` | Identify the kind of role (`Role` or `ClusterRole`) to be used in the role binding | |
| `roleBindings[n].role.name` | Identify the name of the role to be used in the role binding | |
| `roleBindings[n].subject.kind` | Identify the kind of subject (`User`, `Group`, or `ServiceAccount` ) to be used in the role binding | |
| `roleBindings[n].subject.name` | Identify the name of the subject to be used in the role binding | |
| `namespace` | Specify a namespace to be created and used, overriding the one on the command line | |
| `namespaceAttributes.annotations` | Specify annotations to be attached to the namespace | |
| `namespaceAttributes.lables` | Specify labels to be attached to the namespace | |
