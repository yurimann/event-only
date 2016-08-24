class CreateJobApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :job_applications do |t|
      t.string :full_name
      t.string :phone
      t.string :hobby
      t.integer :years_experience
      t.date :available_date

      t.timestamps
    end
  end
end
