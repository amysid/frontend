class ReportsController < ApplicationController
  
  def index
    if params[:report].present?
      if params[:report][:category_id]
        category = Category.find_by(id: params[:report][:category_id])
        @booths = category.blank? ? nil : category.booths 
      end
      if params[:report][:booth_id].present?
        if @booths.present?
          @booths = @booths.where(id: params[:report][:booth_id])
        else
          @booths = Booth.where(id: params[:report][:booth_id])
        end
      end
      if params[:report][:language].present?
        @books = Book.where(language: params[:report][:language])
      end
      if params[:report][:duration].present?
        if @books.present?
          @books = @books.where(audio_type: params[:report][:duration])
        else
          @books = Book.where(audio_type: params[:report][:duration])
        end
      end
      if @books.present?
        @operations = Operation.includes(:book, booth: :categories).where(book_id: @books.pluck(:id)).references(:book, booth: :categories)
      end
      if @booths.present?
        if @operations.present?
          @operations = @operations.includes(:book, booth: :categories).where(booth_id: @booths.pluck(:id)).references(:book, booth: :categories)
        else
          @operations = Operation.includes(:book, booth: :categories).where(booth_id: @booths.pluck(:id)).references(:book, booth: :categories)
        end
      end
      @booth_details = @operations.where(booth_id: params[:report][:booth_id]).group("booths.name").count
    else
      @operations = Operation.includes(:book, booth: :categories).references(:book, booth: :categories)
      @booths = Booth.all.includes(:books)
      @booth_details = @operations.group("booths.name").count
    end
  end

  def time_table_data s_group_id,s_kiosk_id
    sql = <<-SQL
      select case when cast(st.story_type as varchar) isnull then 'TOTAL' else cast(st.story_type as varchar) end as type, sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '12:00AM' then 1 else 0 end) as "12:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '01:00AM' then 1 else 0 end) as "1:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '02:00AM' then 1 else 0 end) as "2:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '03:00AM' then 1 else 0 end) as "3:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '04:00AM' then 1 else 0 end) as "4:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '05:00AM' then 1 else 0 end) as "5:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '06:00AM' then 1 else 0 end) as "6:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '07:00AM' then 1 else 0 end) as "7:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '08:00AM' then 1 else 0 end) as "8:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '09:00AM' then 1 else 0 end) as "9:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '10:00AM' then 1 else 0 end) as "10:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '11:00AM' then 1 else 0 end) as "11:00AM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '12:00PM' then 1 else 0 end) as "12:00PM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '01:00PM' then 1 else 0 end) as "1:00PM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '02:00PM' then 1 else 0 end) as "2:00PM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '03:00PM' then 1 else 0 end) as "3:00PM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '04:00PM' then 1 else 0 end) as "4:00PM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '05:00PM' then 1 else 0 end) as "5:00PM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '06:00PM' then 1 else 0 end) as "6:00PM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '07:00PM' then 1 else 0 end) as "7:00PM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '08:00PM' then 1 else 0 end) as "8:00PM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '09:00PM' then 1 else 0 end) as "9:00PM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '10:00PM' then 1 else 0 end) as "10:00PM", sum(case when to_char((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh'), 'HH:00AM') = '11:00PM' then 1 else 0 end) as "11:00PM" from printing_logs as pl, groups_kiosks as kg, stories as st where kg.kiosk_id = pl.kiosk_id and st.id = pl.story_id and cast((pl.created_at at time zone 'utc' at time zone 'Asia/Riyadh') as date)  between cast('#{min_date}' as date) and '#{max_date}' #{"and kg.group_id = '#{s_group_id}'" if s_group_id.present?} #{"and kg.kiosk_id = '#{s_kiosk_id}'" if s_kiosk_id.present?} group by ROLLUP(st.story_type) order by  st.story_type;
    SQL
    begin
      records_array = Group.find_by_sql(sql)
    rescue Exception => e
      []
    end
  end
end
