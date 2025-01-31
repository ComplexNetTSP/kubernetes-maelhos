
# Do a barrel roll

## Check history

kctl rollout history deployment/webappnodb
kctl rollout history deployment/webapp

## Rollback

kctl rollout undo deployment/webapp
kctl rollout undo deployment/webappnodb

## Rollin

kctl set image deployment/webapp webapp=gmogoat/webapp:v1337
kctl set image deployment/webappnodb webappnodb=gmogoat/webappnodb:v1337
