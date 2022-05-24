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

    stage('Cluster setup') {
      steps {
        echo 'Setup Cluster'
        sh 'az aks create --resource-group coitResourceGroup --name coitQACluster --node-count 1 --generate-ssh-keys'
      }
    }

    stage('Deploy to QA') {
      steps {
        echo 'Deploy to QA'
        sh '''az aks get-credentials --resource-group coitResourceGroup --name coitQACluster

kubectl get nodes

kubectl apply \\
    -f resource-manifests/multicloud/coit-config-map.yaml \\
    -f resource-manifests/multicloud/coit-backend1-deployment.yaml \\
    -f resource-manifests/multicloud/coit-backend2-deployment.yaml \\
    -f resource-manifests/multicloud/coit-frontend-deployment.yaml \\
    -f resource-manifests/multicloud/service-coit-backend1-lb.yaml \\
    -f resource-manifests/multicloud/service-coit-backend2.yaml \\
    -f resource-manifests/multicloud/service-coit-frontend-lb.yaml \\
    -f resource-manifests/multicloud/hpa-coit-frontend.yaml \\
    -f resource-manifests/multicloud/ingress-coit-frontend.yaml

# kubectl get service azure-vote-front --watch


kubectl get all -o wide

'''
      }
    }

    stage('Testing...') {
      steps {
        echo 'Testing...'
      }
    }

    stage('Teardown') {
      steps {
        echo 'Teardown the cluster'
        sh 'az group delete --name coitResourceGroup --yes --no-wait'
      }
    }

  }
}