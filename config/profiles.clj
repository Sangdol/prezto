{:user {:plugins [[com.jakemccrary/lein-test-refresh "0.24.1"]]
        :dependencies [[pjstadig/humane-test-output "0.9.0"]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]}}
