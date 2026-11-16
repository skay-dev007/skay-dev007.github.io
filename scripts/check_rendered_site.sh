#!/bin/sh

set -eu

site_dir=${1:-_site}
index_file="$site_dir/index.html"

test -f "$index_file"

ruby - "$index_file" <<'RUBY'
html = File.read(ARGV.fetch(0))

about = html[/<section class="section summary-section">.*?<\/section>/m]
abort "About section was not rendered." unless about
abort "About section must contain three paragraphs." unless about.scan("<p>").length == 3
normalized_about = about.tr("’", "'")

[
  "I'm an Applied AI Engineer and Researcher with 3+ years of experience",
  "My work spans LLMs, RAG, and applied machine learning",
  "I'm particularly interested in bridging AI research and practical applications"
].each do |phrase|
  abort "Missing About text: #{phrase}" unless normalized_about.include?(phrase)
end

skills = html[/<div class="skills-interests-container.*?<\/div>/m]
abort "Skills & Interests block was not rendered." unless skills
abort "Skills & Interests heading was not rendered." unless skills.include?("Skills &amp; Interests")
abort "Skills must be inline rather than a list." if skills.include?("<li")
abort "Skills must use dot separators." unless skills.scan("&middot;").length == 4

[
  "Applied Machine Learning",
  "LLM Evaluation",
  "Retrieval Augmented Generation",
  "Model Fine-tuning and Deployment",
  "Reinforcement Learning"
].each do |skill|
  abort "Missing skill: #{skill}" unless skills.include?(skill)
end

skills_position = html.index('class="skills-interests-container')
awards_position = html.index('class="awards-container')
abort "Skills & Interests must appear above Awards." unless skills_position && awards_position && skills_position < awards_position
RUBY

echo 'Rendered site checks passed.'
