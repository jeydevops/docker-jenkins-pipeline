node {
   // Mark the code checkout 'stage'....
   stage 'Checkout'
   checkout scm

   stage 'Build application'

   def mvnHome = tool 'M3'
   sh "${mvnHome}/bin/mvn clean install"

   step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])


   stage 'Build Docker image'

   def image = docker.build('infinityworks/dropwizard-example:snapshot', '.')

   stage 'Acceptance Tests'
   image.withRun('-p 8181:8181') {c ->
        sleep 120
        sh "${mvnHome}/bin/mvn verify"
   }

   /* Archive acceptance tests results */
   step([$class: 'JUnitResultArchiver', testResults: '**/target/failsafe-reports/TEST-*.xml'])

   stage 'Push image'
   docker.withRegistry("https://registry.infinityworks.com", "docker-registry") {
          image.push()
   }

}
