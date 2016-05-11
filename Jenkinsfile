node {
   // Mark the code checkout 'stage'....
   stage 'Checkout'
   checkout scm

   stage 'Build application'

   stage 'Build'

   def mvnHome = tool 'M3'
   sh "${mvnHome}/bin/mvn clean install"

   step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])

   // setting permissions
   sh "chown jenkins /var/run/docker.sock"
   sh "chown jenkins /usr/bin/docker"

   stage 'Build Docker image'

   def image = docker.build('infinityworks/dropwizard-example:snapshot', '.')

   stage 'Acceptance Tests'
   image.withRun('-p 8181:8181') {c ->
        sh "${mvnHome}/bin/mvn verify"
   }

   sh "su jenkins"
   /* Archive acceptance tests results */
   step([$class: 'JUnitResultArchiver', testResults: '**/target/failsafe-reports/TEST-*.xml'])
}
