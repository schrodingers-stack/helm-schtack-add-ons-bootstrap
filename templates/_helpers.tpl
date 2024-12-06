{{/*
Expand the name of the chart.
*/}}
{{- define "cluster-add-ons.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cluster-add-ons.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cluster-add-ons.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- default .Values.clusterName .Values.nameOverride -}}
{{- end -}}
{{- end -}}

{{/*
Define application-specific labels to improve application finding in the Argo CD UI.
*/}}
{{- define "cluster-add-ons.appLabels" -}}
{{- if .addOnName -}}
application: {{ .addOnName }}
{{ end -}}
project: {{ include "cluster-add-ons.fullname" .context }}
cluster: {{ .context.Values.destinationCluster.name }}
{{- end }}

{{/*
Define shared labels.
*/}}
{{- define "cluster-add-ons.labels" -}}
helm.sh/chart: {{ include "cluster-add-ons.chart" .context }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
app.kubernetes.io/part-of: {{ .context.Chart.Name }}
{{- with .context.Values.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Construct the namespace for all namespaced resources.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
Preserve the default behavior of the Release namespace if no override is provided.
*/}}
{{- define "cluster-add-ons.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}
