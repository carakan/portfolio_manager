require 'portfolio_manager/rest/utils'

module PortfolioManager
  module REST
    ##
    # Basic account
    # @see http://portfoliomanager.energystar.gov/webservices/home/api/account
    module Account
      include PortfolioManager::REST::Utils

      ##
      # This web service retrieves your account information that includes your
      # username, password, contact information, & security questions/answers.
      #
      # @see http://portfoliomanager.energystar.gov/webservices/home/api/account/account/get
      def account
        perform_get_request('/account')
      end

      # This web service creates an account for a customer based on the information 
      # provided in the XML request and establishes a connection to your account. 
      # It returns the unique identifier to the newly created account and a link 
      # to the corresponding web service to retrieve it.
      #
      # see https://portfoliomanager.energystar.gov/webservices/home/api/account/customer/post
      def create_customer(post_data)
        perform_post_request('/customer', body: post_data)
      end
    end
  end
end
