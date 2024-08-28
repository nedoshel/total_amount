class LockService
  class << self
    # def with_lock(&block)
    #   redis.multi do |multi|
    #     block.call
    #   end
    # end

    def with_lock
      lock_key = 'pg_lock'.to_s.split('').map { |a| a.ord }.join

      begin
        ActiveRecord::Base.connection.execute("SELECT pg_advisory_lock(#{lock_key})")
        yield
      ensure
        ActiveRecord::Base.connection.execute("SELECT pg_advisory_unlock(#{lock_key})")
      end
    end
  end
end
