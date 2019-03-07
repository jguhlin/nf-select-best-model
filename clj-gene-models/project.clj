(defproject clj-gene-models "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.10.0"]
                 [aysylu/loom "1.0.2"]
                 [proto-repl "0.3.1"]
                 [biotools "0.1.1-b1"]]
  :main ^:skip-aot clj-gene-models.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
