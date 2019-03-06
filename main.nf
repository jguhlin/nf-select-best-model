params.current = "Vvulg.r3.gff3"
params.current_proteome = "Vvulg.r3.proteins.aa"
params.new_models = "predicted_genes.gff3"
params.new_models_proteome = "predicted_genes.aa"

params.output = "output.gff3"

current = file(params.current)
new_models = file(params.new_models)

current_proteome_p = file(params.current_proteome)
new_models_proteome_p = file(params.new_models_proteome)

process sortGffFiles {
  conda 'bioconda::gff3sort'
  input:
    file(current)
    file(new_models)

  output:
    file("current.sorted.gff3") into current_models_sorted
    file("new.sorted.gff3") into new_models_sorted
    file("new.genes.gff3") into new_genes_only
    file("current.genes.gff3") into current_genes_only

    """
    gff3sort.pl ${current} --precise --chr_order natural > current.sorted.gff3
    gff3sort.pl ${new_models} --precise --chr_order natural > new.sorted.gff3

    perl $baseDir/scripts/filter_genes.pl current.sorted.gff3 > current.genes.gff3
    perl $baseDir/scripts/filter_genes.pl new.sorted.gff3 > new.genes.gff3
    """
}

process indexProteomes {
  conda 'bioconda::samtools'

  input:
    file(current_proteome_p)
    file(new_models_proteome_p)

  output:
    file("current.aa.fai") into current_proteome_index
    file("current.aa") into current_proteome
    file("new.aa.fai") into new_models_proteome_index
    file("new.aa") into new_models_proteome

    """
    mv ${current_proteome_p} current.aa
    samtools faidx current.aa
    mv ${new_models_proteome_p} new.aa
    samtools faidx new.aa
    """
}

process findIntersects {
  conda 'bioconda::bedtools'

  input:
    file(current_genes_only)
    file(new_genes_only)

  output:
    file("intersections.tsv") into intersects

  """
  bedtools intersect -wa -wb -a current.genes.gff3 -b new.genes.gff3 | cut -f 9,18 > intersects.tsv
  perl $baseDir/scripts/parse_intersects_file.pl > intersections.tsv
  """
}
