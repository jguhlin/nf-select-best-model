(ns clj-gene-models.core
  (:gen-class)
  (:require [loom.graph         :as graph]
            [loom.alg           :as alg]
            [biotools.gff       :as gff]
            [biotools.fasta     :as fasta]
            [clojure.java.shell :as sh]))

; So first we have to handle the intersections, then we have to add any genes
; that do not intersect

(defn split-by-tab [x]
  (clojure.string/split x #"\t"))

(defn parse-intersects-file []
 (with-open [rdr (clojure.java.io/reader "intersections.tsv")]
   (let [lines (line-seq rdr)]
       (doall
        (for [[one two] (map split-by-tab lines)]
          [one two])))))

(defn get-graph []
 (apply graph/digraph (parse-intersects-file)))

(defn remove-redundancy [new-proteome grouping]
  (for [protein grouping]))

(defn -main
  [& args]
  (let [intersection-graph   (get-graph)
        connected-components (alg/connected-components intersection-graph)
        current-proteome     (into {} (fasta/process-fasta "current.aa" [(:id entry) (:seq entry)]))
        new-proteome         (into {} (fasta/process-fasta "new.aa" [(:id entry) (:seq entry)]))]

    (println (count current-proteome) "in current set")
    (println (count new-proteome) "in new set")
    (println "Identified" (count connected-components) "instances of overlaps")))
