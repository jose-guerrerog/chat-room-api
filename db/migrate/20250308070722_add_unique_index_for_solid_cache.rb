class AddUniqueIndexForSolidCache < ActiveRecord::Migration[8.0]
  def change
    # Only add indexes if the tables exist
    if table_exists?(:solid_cache_entries)
      add_index :solid_cache_entries, :id, unique: true, if_not_exists: true
    end
    
    if table_exists?(:solid_queue_jobs)
      add_index :solid_queue_jobs, :id, unique: true, if_not_exists: true
    end
    
    if table_exists?(:solid_queue_processes)
      add_index :solid_queue_processes, :id, unique: true, if_not_exists: true
    end
    
    if table_exists?(:solid_queue_scheduled_executions)
      add_index :solid_queue_scheduled_executions, :id, unique: true, if_not_exists: true
    end
    
    if table_exists?(:solid_queue_semaphores)
      add_index :solid_queue_semaphores, :id, unique: true, if_not_exists: true
    end
  end
end
