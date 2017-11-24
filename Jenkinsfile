node {
   // Mark the code checkout 'stage'....
   stage 'Checkout'
   checkout scm

   sh "sudo chown jenkins /var/run/docker.sock"
   sh "sudo chown jenkins /usr/bin/docker"

   stage 'Build application'

   def mvnHome = tool 'M3'
   sh "${mvnHome}/bin/mvn clean package"

   step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])


   stage 'Build Docker image'

   def image = docker.build('devopsbasservice/dropwizard-example:snapshot', '.')

   stage 'Acceptance Tests'
   image.withRun('-p 9191:9090') {c ->
        sh "${mvnHome}/bin/mvn verify"
   }

   /* Archive acceptance tests results */
   step([$class: 'JUnitResultArchiver', testResults: '**/target/failsafe-reports/TEST-*.xml'])

   stage 'Push image'
   docker.withRegistry("https://index.docker.io/v1/", "docker-registry") {
          image.push()
   }

}
