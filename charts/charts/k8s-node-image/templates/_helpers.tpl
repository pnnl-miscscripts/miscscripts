{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "k8s-node-image.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "k8s-node-image.fullname" -}}
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
{{- define "k8s-node-image.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "k8s-node-image.anaconda.fullname" -}}
{{- $f := include "k8s-node-image.fullname" . }}
{{- $f | trunc 59 | trimSuffix "-" -}}-ana
{{- end -}}

{{- define "k8s-node-image.k8s-node.fullname" -}}
{{- $f := include "k8s-node-image.fullname" . }}
{{- $f | trunc 58 | trimSuffix "-" -}}-node
{{- end -}}

{{- define "k8s-node-image.ingress.regex" -}}
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

{{- define "k8s-node-image.ingress.noregex" -}}
{{- if gt (len .suffix) 0 }}
  {{- printf "%s/%s" .prefix .suffix }}
{{- else }}
  {{- printf "%s/" .prefix }}
{{- end }}
{{- end -}}

{{- define "k8s-node-image.ingress.prefix" -}}
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
{{- define "k8s-node-image.ingress" -}}
{{- if .dot.Values.ingress.regex }}
{{- include "k8s-node-image.ingress.regex" . }}
{{- else }}
{{- include "k8s-node-image.ingress.noregex" . }}
{{- end }}
{{- end -}}

