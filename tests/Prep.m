classdef Prep < matlab.unittest.TestCase
    % Setup and teardown for tests.
    properties (Constant)
        CONN_INFO = struct(...
            'host', getenv('DJ_HOST'), ...
            'user', getenv('DJ_USER'), ...
            'password', getenv('DJ_PASS'));
        PREFIX = 'u19_test_';
    end
    methods (TestClassSetup)
        function init(testCase)
            disp('---------------INIT---------------');
            clear functions;
            dj.config('safemode', false);
            curr_conn = dj.conn(testCase.CONN_INFO.host, ...
                testCase.CONN_INFO.user, testCase.CONN_INFO.password,'',true);
            setenv('DB_PREFIX', testCase.PREFIX)
        end
    end
    methods (TestClassTeardown)
        function dispose(testCase)
            disp('---------------DISP---------------');
            dj.config('safemode', false);
            curr_conn = dj.conn(testCase.CONN_INFO.host, ...
                testCase.CONN_INFO.user, testCase.CONN_INFO.password, '',true);

            % remove databases
            curr_conn.query('SET FOREIGN_KEY_CHECKS=0;');
            res = curr_conn.query(['SHOW DATABASES LIKE "' testCase.PREFIX '_%";']);
            for i = 1:length(res.(['Database (' testCase.PREFIX '_%)']))
                curr_conn.query(['DROP DATABASE ' ...
                    res.(['Database (' testCase.PREFIX '_%)']){i} ';']);
            end
            curr_conn.query('SET FOREIGN_KEY_CHECKS=1;');

            res = curr_conn.query(sprintf('%s',cmd{:}));
            curr_conn.delete;
        end
    end
end
