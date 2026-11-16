#!/bin/sh

set -eu

root_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$root_dir"

test ! -e CNAME
test -f assets/images/swati-profile.jpg
grep -q '^title: Swati | Applied AI Engineer & Researcher$' _config.yml
grep -q "^url: 'https://skay-dev007.github.io'$" _config.yml
grep -q '^exclude:$' _config.yml
grep -q '^  - docs$' _config.yml
grep -q '^  name: Swati$' _data/data.yml
grep -q '^  tagline: Applied AI Engineer & Researcher$' _data/data.yml
grep -q '^  avatar: swati-profile.jpg$' _data/data.yml
grep -q '^  github: skay-dev007$' _data/data.yml
grep -q "I'm an Applied AI Engineer and Researcher with 3+ years of experience" _data/data.yml
grep -q 'University of British Columbia,' _data/data.yml
grep -q '^    Vancouver\.' _data/data.yml
grep -q "I've worked on AI and ML projects across healthcare" _data/data.yml
grep -q 'building and deploying working systems' _data/data.yml
if rg -n 'improving accuracy by 40%|improving weighted F1 by 37%' _data/data.yml; then
  echo 'Removed experience metrics are still present.' >&2
  exit 1
fi
grep -q '^experiences:$' _data/data.yml
grep -q '^  - role: Machine Learning Engineer' _data/data.yml
grep -q '^  - role: Machine Learning Researcher' _data/data.yml
grep -q '^  - role: Graduate Research Assistant' _data/data.yml
grep -q '^  - role: Applied ML Research Intern' _data/data.yml
grep -q '^  - role: Research Associate' _data/data.yml
grep -q '^publications:$' _data/data.yml
grep -q '^  title: Selected Work$' _data/data.yml
if rg -n 'Selected Publications & Presentations' _data/data.yml; then
  echo 'The old publications heading is still present.' >&2
  exit 1
fi
grep -q 'Even Irrelevant Medical Context Weakens Refusal' _data/data.yml
grep -q 'Understanding the Potential of Machine Learning to Improve Telephone Triage Decisions' _data/data.yml
grep -q 'Exploring the potential of LLMs for biomedical relation extraction' _data/data.yml
grep -q 'Deep Albedo: A Spatially Aware Autoencoder Approach' _data/data.yml
grep -q 'Inclusive & Photorealistic Albedo Editing Through Latent Space Translation' _data/data.yml
grep -q 'Aspect-based Summarization of Legal Case Files using Sentence Classification' _data/data.yml
test "$(grep -c '^  - title:' _data/data.yml)" -eq 6
grep -q '^awards:$' _data/data.yml
grep -q '^  title: Awards$' _data/data.yml
grep -q '^  - name: UBC Graduate Tuition Award$' _data/data.yml
grep -q '^    time: 2021-2024$' _data/data.yml
grep -q '^  - name: GHC Scholar$' _data/data.yml
grep -q '^    time: 2023$' _data/data.yml
grep -q '^  - name: Generation Google Scholar$' _data/data.yml
grep -q '^    time: 2022$' _data/data.yml
grep -q '^  - name: Mitacs Graduate Fellow$' _data/data.yml
grep -q '^    time: 2021$' _data/data.yml
test "$(grep -c '^  - name:' _data/data.yml)" -eq 4

publications_line=$(rg -n -m 1 '\{% include publications.html %\}' index.html | cut -d: -f1)
experiences_line=$(rg -n -m 1 '\{% include experiences.html %\}' index.html | cut -d: -f1)
test "$publications_line" -lt "$experiences_line"
if rg -n '\{% include awards.html %\}' index.html; then
  echo 'Awards must not render in the main column.' >&2
  exit 1
fi
contact_line=$(rg -n -m 1 '\{% include contact.html %\}' _includes/sidebar.html | cut -d: -f1)
awards_line=$(rg -n -m 1 '\{% include awards.html %\}' _includes/sidebar.html | cut -d: -f1)
test "$contact_line" -lt "$awards_line"
grep -q 'awards-container education-container container-block' _includes/awards.html

grep -q '^  linkedin: "swati&#107;anwal"$' _data/data.yml
grep -q '^  medium: "swatiii&#107;anwal.medium.com"$' _data/data.yml
grep -q '^  x: "swatiii&#107;anwal"$' _data/data.yml
grep -q '>LinkedIn</a>' _includes/contact.html
grep -q '>Medium</a>' _includes/contact.html
grep -q 'href="https://x.com/{{ sidebar.x }}"' _includes/contact.html
grep -q '>X</a>' _includes/contact.html
grep -q 'rel="noreferrer nofollow noopener"' _includes/contact.html

if rg -n -i 'Alan Doe|example@email|012 345|lorem ipsum|UA-[0-9]|linkedin.com/in|swatikanwal|kanwal' \
  _config.yml _data README.md; then
  echo 'Stage 1 contains sample or deferred personal content.' >&2
  exit 1
fi

echo 'Stage 1 content checks passed.'
