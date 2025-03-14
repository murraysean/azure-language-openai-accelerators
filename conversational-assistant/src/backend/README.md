# Conversational-Assistant: Backend 

## Environment Variables
Expected environment variables:
```
AOAI_ENDPOINT=<aoai-service-endpoint>
AOAI_DEPLOYMENT=<aoai-service-gpt-deployment-name>

SEARCH_ENDPOINT=<search-service-endpoint>
SEARCH_INDEX_NAME=<search-service-index-name>

LANGUAGE_ENDPOINT=<language-service-endpoint>

CLU_PROJECT_NAME=<clu-project-name>
CLU_DEPLOYMENT_NAME=<clu-deployment-name>
CLU_CONFIDENCE_THRESHOLD=<clu-confidence-threshold> # float

CQA_PROJECT_NAME=<cqa-project-name>
CQA_DEPLOYMENT_NAME=production # default
CQA_CONFIDENCE_THRESHOLD=<cqa-confidence-threshold> # float

ORCHESTRATION_PROJECT_NAME=<orchestration-project-name>
ORCHESTRATION_DEPLOYMENT_NAME=<orchestration-deployment-name>
ORCHESTRATION_CONFIDENCE_THRESHOLD=<orchestration-confidence-threshold> # float

PII_ENABLED=<pii-enabled> # bool
PII_CATEGORIES=<pii-categories> # comma-separated
PII_CONFIDENCE_THRESHOLD=<pii-confidence-threshold> # float

ROUTER_TYPE=<router-type> # BYPASS | CLU | CQA | ORCHESTRATION | FUNCTION_CALLING
```

## Running Server
```
pip install -r requirements.txt
cd src
flask --app server run --host=0.0.0.0 --port 7000
```
