class Api::V1::ChatController < ApplicationController
  include Tubesock::Hijack

  def chat
    hijack do |tubesock|
      tubesock.onopen do
        tubesock.send_data "Hello, friend"
      end

      tubesock.onmessage do |data|
        b = Benchmark.ms { Player.last.tick }
        tubesock.send_data "You said: #{data} #{b.to_s}"
      end
    end
  end
end