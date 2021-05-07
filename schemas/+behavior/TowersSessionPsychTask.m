%{
-> behavior.TowersSession
blocks_type: varchar(16)
-----
blocks_delta_data=null      : blob   # num of right - num of left, x ticks for data
blocks_pright_data=null     : blob   # percentage went right for each delta bin for data
blocks_delta_error=null     : blob   # num of right - num of left, x ticks for data confidence interval
blocks_pright_error=null    : blob   # confidence interval for precentage went right of data
blocks_delta_fit=null       : blob   # num of right - num of left, x ticks for fitting results
blocks_pright_fit=null      : blob   # fitting results for percent went right
%}

classdef TowersSessionPsychTask < dj.Computed

    methods(Access=protected)

        function makeTuples(self, key)

            deltaBins           = -15:3:15;       % controls binning of #R - #L
            deltaBins           = deltaBins(:);

            blocksWithLevel = proj(behavior.TowersBlock, 'level') * proj(acquisition.Session, 'level->session_level') & key;

            mainBlocks = blocksWithLevel & 'session_level=level';
            guidingBlocks = blocksWithLevel & 'session_level>level';

            [numTowersR, numTowersL, choices] = fetch1(behavior.TowersSession & key, 'num_towers_r', 'num_towers_l', 'chosen_side');

            % construct indices of main block trials
            blocks_types = {'main', 'guiding'};
            blocks = [mainBlocks, guidingBlocks];
            for iblocks = 1:length(blocks)
                blocks_count = count(behavior.TowersBlock & proj(blocks(iblocks)));
                if blocks_count
                    [first_trials, n_trials] = fetchn(behavior.TowersBlock & proj(blocks(iblocks)), 'first_trial', 'n_trials');
                    trials_indices = [];
                    for i = 1:length(first_trials)
                        trials_indices = [trials_indices, first_trials(i):n_trials(i)];
                    end

                    num_towers_r_sub = numTowersR(trials_indices);
                    num_towers_l_sub = numTowersL(trials_indices);
                    choices_sub = choices(trials_indices);

                    fit_results = behavior.utils.psychFit(deltaBins, num_towers_r_sub, num_towers_l_sub, choices_sub);

                    f = fieldnames(fit_results);

                    key_subtype = key;
                    for i = 1:length(f)
                       key_subtype.(strcat('blocks_', f{i})) = fit_results.(f{i});
                    end
                    key_subtype.blocks_type = blocks_types{iblocks};
                    self.insert(key_subtype)
                end
            end

        end
    end
end
