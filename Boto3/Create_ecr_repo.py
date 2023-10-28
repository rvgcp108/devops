import boto3

repo_name = 'rvrepo_demo'
client = boto3.client('ecr')
if repo_name == True:
    print("Repository already exist {repo_name}",repository_uri)
else:
    response = client.create_repository(
    repositoryName=repo_name,
    tags=[
        {
            'Key': 'Name',
            'Value': 'demo'
        },
    ],
    )
    repository_uri =response['repository']['repositoryUri']
    print(repository_uri)
