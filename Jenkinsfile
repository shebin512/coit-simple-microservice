pipeline {
  agent any
  stages {
    stage('Build Containers') {
      agent any
      steps {
        pwd()
        echo 'Building Containers'
        dir(path: 'coit-backend1') {
          sh '''docker build -t shebin512/coit-backend1:latest -f Dockerfile-multistage .
docker push shebin512/coit-backend1:latest'''
        }

        dir(path: 'coit-backend2') {
          sh '''docker build -t shebin512/coit-backend2:latest -f Dockerfile .
docker push shebin512/coit-backend2:latest
'''
        }

        dir(path: 'coit-frontend') {
          sh '''docker build -f Dockerfile-multistage -t shebin512/coit-frontend:latest .
docker push shebin512/coit-frontend:latest'''
        }

      }
    }

    stage('Deploy to QA') {
      steps {
        echo 'Deploy to QA'
        sh '''az aks create \\
    --resource-group myResourceGroup \\
    --name myAKSCluster \\
    --node-count 2 \\
    --generate-ssh-keys \\
    --attach-acr <acrName>'''
      }
    }

  }
}