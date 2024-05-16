# frozen_string_literal: true

def create_app(name)
  application = Application.find_or_create_by(
    name: name
  )
  Cache::Service.new.add_registered_application(application.id)

  application
end

def generate_data(metrics, data_points_per_metric)
  metrics.map do |metric_name|
    data_points_per_metric.times.map do
      {
        name: metric_name,
        value: rand(5..(data_points_per_metric * 3)),
        timestamp: Faker::Time.between(to: 1.days.ago, from: 3.month.ago).to_i
      }
    end
  end.flatten
end

marketing_app = create_app('Marketing')
Metrics::Service.new.create_metrics(
  marketing_app.id,
  generate_data(
    %w[leads_generated posts_created videos_created return_of_investment impression_share cost_per_click
       bounce_rate], 50
  )
)

sales_app = create_app('Sales')
Metrics::Service.new.create_metrics(
  sales_app.id,
  generate_data(%w[deals_closed prospects_generate meetings pitches_progressed churns avg_order_value], 50)
)

infrastructure_aws_app = create_app('AWS infrastructure')
Metrics::Service.new.create_metrics(
  infrastructure_aws_app.id,
  generate_data(%w[used_vms requests_per_minute cpu_utilization memory_utilization k8s_clusters], 50)
)

infrastructure_gcp_app = create_app('GCP infrastructure')
Metrics::Service.new.create_metrics(
  infrastructure_gcp_app.id,
  generate_data(%w[used_vms requests_per_minute cpu_utilization memory_utilization k8s_clusters], 50)
)

authentication_service_app = create_app('Backend: authentication service')
Metrics::Service.new.create_metrics(
  authentication_service_app.id,
  generate_data(
    %w[success_requests failed_requests flow_for_social_login flow_for_email_sign_up flow_for_email_login
       response_time_ms], 100
  )
)

ordering_service_app = create_app('Backend: ordering service')
Metrics::Service.new.create_metrics(
  ordering_service_app.id,
  generate_data(
    %w[success_requests failed_requests order_started order_finished order_canceled new_order_ux_flow
       response_time_ms], 100
  )
)

website_app = create_app('Fronted: website')
Metrics::Service.new.create_metrics(
  website_app.id,
  generate_data(
    %w[landing_page_visits pricing_page_visits book_call_page_visits about_page_visits careers_page_visits
       page_initial_load_ms], 100
  )
)

dashboard_app = create_app('Fronted: dashboard')
Metrics::Service.new.create_metrics(
  dashboard_app.id,
  generate_data(
    %w[ordering_page_visits open_basket_page_visits search_box_used update_profile_page_visits
       page_initial_load_ms], 100
  )
)

android_app = create_app('Mobile: android')
Metrics::Service.new.create_metrics(
  android_app.id,
  generate_data(
    %w[cold_app_launch_ms hot_app_launch ordering_page_visits open_basket_page_visits search_box_used
       update_profile_page_visits], 100
  )
)

ios_app = create_app('Mobile: ios')
Metrics::Service.new.create_metrics(
  ios_app.id,
  generate_data(
    %w[cold_app_launch_ms hot_app_launch ordering_page_visits open_basket_page_visits search_box_used
       update_profile_page_visits], 100
  )
)

Metric.searchkick_index.delete
Metric.reindex
