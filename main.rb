# the following code grabs a variety reports from AMION API and saves it in sample_reports
# parser not yet implemented because there can be a variety of report formats,
# each of which will require a specialized parser


require_relative "lib/amion_adapter"
account = "account_name"

amion_adapter = AmionAdapter.new( account )

  ["625c", "2", "34", "619"].each do |report_code|

    raw = amion_adapter.fetch_report(report_code, Date.today)

    File.open("sample_reports/data-#{account}-#{report_code}", 'w') { |file| file.write(raw) }
  end
end