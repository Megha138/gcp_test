pipeline {
   agent { 
        label 'hellow-slave'
   }

   tools {
      // Install the Maven version configured as and add it to the path.
      maven "mvn"
      jdk "jdk8"
   }

   stages {
      stage('SCM Checkout') {
         steps {
            println "============= SCM Checkout =============="
            git credentialsId: 'source:infosys-gcp-demo-project', url: 'https://source.developers.google.com/p/infosys-gcp-demo-project/r/springapp-bluegreen-gdm-ansible'
         }
      }
      stage('Build, Package & JUnit') {
          steps {
            println "============== Build, Package & JUnit ================"
            sh "mvn clean install -Dmaven.test.failure.ignore=true"
            sh "docker build --tag gcpans ."
            sh "docker tag gcpans gcr.io/infosys-gcp-demo-project/test-jk:latest"
         }
   
      }
      stage('Deploy on QA') {
          steps {
            println "============== Deploy and Split Traffic=================="
            withCredentials([file(credentialsId: "gcp-key", variable: 'GOOGLE_APPLICATION_CREDENTIALS')])
        	{
        		sh("gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS")
        		sh("gcloud docker -- push gcr.io/infosys-gcp-demo-project/test-jk:latest")
                        sh("gcloud deployment-manager deployments create my-container-deployment  --config container_vm.yaml")

        	}
         }
      }
 }
  
}
   
