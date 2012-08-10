module Pacer::Pipes
  class EdgesPipe < AbstractPipe
    attr_reader :starts

    def setStarts(starts)
      @starts = starts.first
      self.iter = @starts.getEdges.iterator
    end

    def processNextStart
      iter.next
    rescue NativeException => e
      if e.cause.getClass == Pacer::NoSuchElementException.getClass
        raise e.cause
      else
        raise e
      end
    end

    def reset
      self.iter = @starts.getEdges.iterator
    end

    private

    attr_accessor :iter
  end
end