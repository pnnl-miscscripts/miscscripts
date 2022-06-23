{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "pnnlmiscscripts.k8s-node-image-full.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pnnlmiscscripts.k8s-node-image-full.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pnnlmiscscripts.k8s-node-image-full.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "pnnlmiscscripts.k8s-node-image-full.anaconda.fullname" -}}
{{- $f := include "pnnlmiscscripts.k8s-node-image-full.fullname" . }}
{{- $f | trunc 59 | trimSuffix "-" -}}-ana
{{- end -}}

{{- define "pnnlmiscscripts.k8s-node-image-full.k8s-node.fullname" -}}
{{- $f := include "pnnlmiscscripts.k8s-node-image-full.fullname" . }}
{{- $f | trunc 58 | trimSuffix "-" -}}-node
{{- end -}}

{{- define "pnnlmiscscripts.k8s-node-image-full.ingress.regex" -}}
{{- if gt (len .suffix) 0 }}
  {{- if eq .type "d" }}
    {{- printf "%s/(%s$|%s/.*)" .prefix .suffix .suffix }}
  {{- else }}
    {{- printf "%s/(%s$)" .prefix .suffix }}
  {{- end }}
{{- else }}
  {{- printf "%s/?(.*)$" .prefix }}
{{- end }}
{{- end -}}

{{- define "pnnlmiscscripts.k8s-node-image-full.ingress.noregex" -}}
{{- if gt (len .suffix) 0 }}
  {{- printf "%s/%s" .prefix .suffix }}
{{- else }}
  {{- printf "%s/" .prefix }}
{{- end }}
{{- end -}}

{{- define "pnnlmiscscripts.k8s-node-image-full.ingress.prefix" -}}
{{- if .Values.ingress.enableVersionPrefix -}}
{{- $tag := dict "dot" . "section" .Values.k8sNode.image | include (printf "%s.tag" .Values.k8sNode.prefix) -}}
{{- printf "%s/%s" .Values.ingress.prefix $tag -}}
{{- else }}
{{- .Values.ingress.prefix -}}
{{- end }}
{{- end }}

{{/*
takes dot, prefix, suffix, and type. type can be either f or d.
*/}}
{{- define "pnnlmiscscripts.k8s-node-image-full.ingress" -}}
{{- if .dot.Values.ingress.regex }}
{{- include "pnnlmiscscripts.k8s-node-image-full.ingress.regex" . }}
{{- else }}
{{- include "pnnlmiscscripts.k8s-node-image-full.ingress.noregex" . }}
{{- end }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "pnnlmiscscripts.k8s-node-image-full.labels" -}}
helm.sh/chart: {{ include "pnnlmiscscripts.k8s-node-image-full.chart" . }}
{{ include "pnnlmiscscripts.k8s-node-image-full.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pnnlmiscscripts.k8s-node-image-full.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pnnlmiscscripts.k8s-node-image-full.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}