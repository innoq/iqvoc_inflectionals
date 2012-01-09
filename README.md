Inflectionals for iQvoc


Getting Started
===============

1. Initialize database:

    $ rake db:drop db:create iqvoc:db:migrate iqvoc_skosxl:db:migrate \
            db:migrate iqvoc:db:seed db:seed

2. Create `config/initializers/secret_token.rb` as explained in iQvoc's README
