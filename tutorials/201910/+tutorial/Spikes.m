%{
-> tutorial.Neuron
-> tutorial.SpikeDetectionParam
-----
spikes: longblob   # detected spikes
count: int         # total number of the detected spikes
%}

classdef Spikes < dj.Computed

	methods(Access=protected)

		function makeTuples(self, key)
            
            activity = fetch1(tutorial.Neuron & key, 'activity');
            threshold = fetch1(tutorial.SpikeDetectionParam & key, 'threshold');
            
            above_thres = activity > threshold;
            rising = diff(above_thres) > 0;
            spikes = [0, rising];
            count = sum(spikes);
            
            % save results and insert
            key.spikes = spikes;
            key.count = count;
			self.insert(key)
		end
	end

end