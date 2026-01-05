{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "namespace.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "namespace.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "namespace.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "namespace.labels" -}}
helm.sh/chart: {{ include "namespace.chart" . }}
{{ include "namespace.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "namespace.selectorLabels" -}}
app.kubernetes.io/name: {{ include "namespace.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the gateway to use
*/}}
{{- define "namespace.gatewayName" -}}
{{ default (printf "%s-gateway" .Values.magicnamespace.namespace) .Values.gateway.name }}
{{- end -}}

{{/*
Create the namespace of the gateway to use
*/}}
{{- define "namespace.gatewayNamespace" -}}
{{- if eq .Values.gateway.deploymentMode "admin" -}}
{{- .Release.Namespace -}}
{{- else if eq .Values.gateway.deploymentMode "tenant" -}}
{{- .Values.magicnamespace.namespace -}}
{{- else if eq .Values.gateway.deploymentMode "custom" -}}
{{- .Values.gateway.customNamespace -}}
{{- end -}}
{{- end -}}

{{/*
Create a filtered list of admin namespace to tenant certificate refs
*/}}
{{- define "namespace.adminToTenantCertificateRefs" -}}
{{- $root := . -}}
{{- $releaseNamespace := .Release.Namespace -}}
{{- $tenantNamespace := .Values.magicnamespace.namespace -}}
{{ $result := list }}
  {{ range $ref := .Values.gateway.httpsListener.certificateRefs }}
    {{ if eq (tpl ($ref.namespace | default $releaseNamespace) $root) $tenantNamespace }}
    {{ $result = append $result $ref }}
    {{- end -}}
  {{- end }}
{{ toJson $result }}
{{- end -}}
