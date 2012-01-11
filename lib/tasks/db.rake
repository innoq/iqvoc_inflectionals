# encoding: UTF-8

namespace :db do

  task :migrate_all => :environment do
    invoke_engine_tasks "db:migrate"
  end

  task :seed_all => :environment do
    invoke_engine_tasks "db:seed"
  end

  def invoke_engine_tasks(task_name)
    engines = %w(iqvoc iqvoc_skosxl)
    tasks = engines.map { |engine| "#{engine}:#{task_name}" }
    tasks << task_name
    tasks.each do |task|
      Rake::Task[task].invoke
    end
  end

end
