class CodimdsController < ApplicationController
  before_action :require_login

  rescue_from Query::StatementInvalid, with: :query_statement_invalid

  helper :queries
  helper :additionals_queries

  include QueriesHelper
  include AdditionalsQueriesHelper

  def show
    additionals_retrieve_query('codimd')

    scope = @query.results_scope
    @limit = per_page_option

#    @db_entries_count = @query.db_entry_count
#    @db_entries_pages = Paginator.new @db_entries_count, per_page_option, params['page']
#    @db_entries = scope.offset(@db_entries_pages.offset).limit(@db_entries_pages.per_page).to_a

    if request.xhr?
      render partial: 'list', layout: false
    else
      render layout: !request.xhr?
    end
  end
end
