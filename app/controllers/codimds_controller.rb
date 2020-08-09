class CodimdsController < ApplicationController
  before_action :require_login
  before_action :find_optional_project, only: %i[show]

  rescue_from Query::StatementInvalid, with: :query_statement_invalid

  helper :queries

  include QueriesHelper

  helper :sort
  include SortHelper

  menu_item :codimds

  def show
    sort_init 'updatedAt', 'desc'
    sort_update %w[title createdAt updatedAt]

    @limit = per_page_option

    scope = CodimdPad.pads @project

    @codimd_pad_count = scope.count
    @codimd_pad_pages = Paginator.new @codimd_pad_count, @limit, params['page']
    @offset ||= @codimd_pad_pages.offset
    @codimd_pads = scope.order(CodimdPad.fix_sort_clause(sort_clause))
                        .limit(@limit)
                        .offset(@offset)
  end
end
