#!/bin/sh

set -eu

root_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$root_dir"

test ! -e CNAME
test -f assets/images/swati-profile.jpg
grep -q '^title: Swati | Applied AI Engineer & Researcher$' _config.yml
grep -q "^url: 'https://skay-dev007.github.io'$" _config.yml
grep -q '^  name: Swati$' _data/data.yml
grep -q '^  tagline: Applied AI Engineer & Researcher$' _data/data.yml
grep -q '^  avatar: swati-profile.jpg$' _data/data.yml
grep -q '^  github: skay-dev007$' _data/data.yml
grep -q '3+ years of hands-on' _data/data.yml
grep -q 'University of British' _data/data.yml
grep -q 'solutions across healthcare' _data/data.yml
grep -q 'regulatory compliance, and legal technology' _data/data.yml
grep -q '^experiences:$' _data/data.yml
grep -q '^  - role: Machine Learning Engineer' _data/data.yml
grep -q '^  - role: Machine Learning Researcher' _data/data.yml
grep -q '^  - role: Graduate Research Assistant' _data/data.yml
grep -q '^  - role: Applied ML Research Intern' _data/data.yml
grep -q '^  - role: Research Associate' _data/data.yml
grep -q '^publications:$' _data/data.yml
grep -q '^  title: Selected Publications & Presentations$' _data/data.yml
grep -q 'Even Irrelevant Medical Context Weakens Refusal' _data/data.yml
grep -q 'Understanding the Potential of Machine Learning to Improve Telephone Triage Decisions' _data/data.yml
grep -q 'Exploring the potential of LLMs for biomedical relation extraction' _data/data.yml
grep -q 'Deep Albedo: A Spatially Aware Autoencoder Approach' _data/data.yml
grep -q 'Inclusive & Photorealistic Albedo Editing Through Latent Space Translation' _data/data.yml
grep -q 'Aspect-based Summarization of Legal Case Files using Sentence Classification' _data/data.yml
test "$(grep -c '^  - title:' _data/data.yml)" -eq 6

if rg -n -i 'Alan Doe|example@email|012 345|lorem ipsum|UA-[0-9]|linkedin.com/in' \
  _config.yml _data README.md; then
  echo 'Stage 1 contains sample or deferred personal content.' >&2
  exit 1
fi

echo 'Stage 1 content checks passed.'
