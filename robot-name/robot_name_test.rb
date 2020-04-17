require 'minitest/autorun'
require_relative './robot_name'

class RobotTest < Minitest::Test
  NAME_REGEXP = /^[A-Z]{2}\d{3}$/

  def test_can_create_a_robot
    refute_nil Robot.new
  end

  def test_has_name
    assert_match NAME_REGEXP, Robot.new.name
  end

  def test_name_sticks
    robot = Robot.new
    original_name = robot.name
    assert_equal original_name, robot.name
  end

  def test_reset_changes_name
    robot = Robot.new
    original_name = robot.name
    robot.reset
    refute_equal original_name, robot.name
  end

  def test_reset_before_name_called_does_not_cause_an_error
    robot = Robot.new
    robot.reset
    assert_match NAME_REGEXP, Robot.new.name
  end

  def test_reset_multiple_times
    robot = Robot.new
    names = []
    5.times do
      robot.reset
      names << robot.name
    end
    # This will probably be 5, but name uniqueness is only a requirement
    # accross multiple robots and consecutive calls to reset.
    assert names.uniq.size > 1
  end

  def test_different_robots_have_different_names
    refute_equal Robot.new.name, Robot.new.name
  end
end
