class Task < ActiveRecord::Base
  belongs_to :project
  attr_accessor :size, :completed_at

  def size
    @size ||= 0
  end

  def mark_completed(date = nil)
    @completed_at = (date || Time.current)
  end

  def complete?
    completed_at.present?
  end

  def part_of_velocity?
    return false unless complete?
    completed_at > 3.weeks.ago
  end

  def points_toward_velocity
    if part_of_velocity? then size else 0 end
  end
end
