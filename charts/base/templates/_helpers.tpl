{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pewty.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "pewty.fullname" -}}
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
Common labels
*/}}
{{- define "pewty.labels" -}}
helm.sh/chart: {{ include "pewty.chart" . }}
{{ include "pewty.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.extraLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "pewty.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pewty.fullname" . }}
app.kubernetes.io/instance: {{ .Values.instance }}
{{- end }}
