classdef useCaseTest < matlab.uitest.TestCase
    properties
        player_0
        player_1
        player_2
        ge
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            import matlab.unittest.TestCase
            % Create instances of 'player'
            testCase.player_0 = player;
            testCase.player_1 = player;
            testCase.player_2 = player;

            % Create instances of 'pokerGameUI'
            % TODO: UI background
            player_0_UI = pokerGameUI;
            testCase.player_0.currUI = player_0_UI;
            testCase.player_0.currUI.currPlayer = testCase.player_0;

            player_1_UI = pokerGameUI;
            testCase.player_1.currUI = player_1_UI;
            testCase.player_1.currUI.currPlayer = testCase.player_1;

            player_2_UI = pokerGameUI;
            testCase.player_2.currUI = player_2_UI;
            testCase.player_2.currUI.currPlayer = testCase.player_2;

            % player_0.currUI.currPlayer = player_0;
            testCase.player_0.currUI.player_1 = testCase.player_1;
            testCase.player_0.currUI.player_2 = testCase.player_2;

            % player_1.currUI.currPlayer = player_1;
            testCase.player_1.currUI.player_1 = testCase.player_0;
            testCase.player_1.currUI.player_2 = testCase.player_2;

            % player_2.currUI.currPlayer = player_2;
            testCase.player_2.currUI.player_1 = testCase.player_0;
            testCase.player_2.currUI.player_2 = testCase.player_1;

            % Create the instance of pokerRule
            rule = pokerRule;

            % Create instance of 'gameEngine'
            testCase.ge = gameEngine;
            testCase.ge.bgm();
            testCase.ge.player_0 = testCase.player_0;
            testCase.ge.player_1 = testCase.player_1;
            testCase.ge.player_2 = testCase.player_2;
            testCase.ge.rule = rule;

            rule.gameEngine = testCase.ge;

            % set gameEngine to different UIs
            testCase.player_0.currUI.gameEngine = testCase.ge;
            testCase.player_1.currUI.gameEngine = testCase.ge;
            testCase.player_2.currUI.gameEngine = testCase.ge;
        end
    end
    
    methods (Test)
        function T1(testCase)
            %Tcover1.1.1.1
            testCase.press(testCase.player_0.currUI.ReadyButton);
            
            testCase.verifyEqual(testCase.ge.isStart, false);
            
            testCase.verifyEqual(testCase.player_0.currUI.CardNum_currplayer.Text, 'Ready');
            testCase.verifyEqual(testCase.player_1.currUI.CardNum_player_1.Text, 'Ready');
            testCase.verifyEqual(testCase.player_2.currUI.CardNum_player_1.Text, 'Ready');
            
            testCase.verifyEqual(testCase.player_0.currUI.ReadyButton.Visible, 'off');
            %Tcover1.1.1.2
            testCase.press(testCase.player_1.currUI.ReadyButton);
            testCase.press(testCase.player_2.currUI.ReadyButton);
            
            testCase.verifyEqual(testCase.ge.isStart, true);
           
            %T1.1.2
            count = 0;
            if testCase.player_0.role == 0
                count = count + 1;
            end
            if testCase.player_1.role == 0
                count = count + 1;
            end
            if testCase.player_2.role == 0
                count = count + 1;
            end
            testCase.verifyEqual(count,1);
           
            %T1.1.3
            card_num = 0;
            if testCase.player_0.role == 0
                card_num = testCase.player_0.cardNum;
            end
            if testCase.player_1.role == 0
                card_num = testCase.player_1.cardNum;
            end
            if testCase.player_2.role == 0
                card_num = testCase.player_2.cardNum;    
            end
            testCase.verifyEqual(card_num,20);
            
            %T1.2.1
            % player_0 UI
            if (testCase.ge.landlord == 0)
                up = 20;
            else
                up = 17;
            end 
            for i = 1 : up
                if (testCase.player_0.currUI.currPlayer.cards_img{3, i} == false)
                    testCase.verifyEqual(testCase.player_0.currUI.currPlayer.cards_img{1, i}.Visible, 'on');
                end
            end
            %player_1 UI
            if (testCase.ge.landlord == 1)
                up = 20;
            else
                up = 17;
            end 
            for i = 1 : up
                if (testCase.player_1.currUI.currPlayer.cards_img{3, i} == false)
                    testCase.verifyEqual(testCase.player_1.currUI.currPlayer.cards_img{1, i}.Visible, 'on');
                end
            end
            %player_2 UI
            if (testCase.ge.landlord == 2)
                up = 20;
            else
                up = 17;
            end 
            for i = 1 : up
                if (testCase.player_2.currUI.currPlayer.cards_img{3, i} == false)
                    testCase.verifyEqual(testCase.player_2.currUI.currPlayer.cards_img{1, i}.Visible, 'on');
                end
            end
            
            %T1.2.2
            pause(5);
            nums = zeros(1,100);
            %player_0
            if (testCase.ge.landlord == 0)
                up = 20;
            else
                up = 17;
            end 
            for i = 1 : up
                k = testCase.player_0.cards{4,i};
                nums(k) = nums(k) + 1;
                if isequal(testCase.player_0.cards{2,i},'clubs')
                    nums(20) = nums(20) + 1;
                elseif isequal(testCase.player_0.cards{2,i},'hearts')
                    nums(21) = nums(21) + 1;
                elseif isequal(testCase.player_0.cards{2,i},'diamonds')
                    nums(22) = nums(22) + 1;
                elseif isequal(testCase.player_0.cards{2,i},'spades')
                    nums(23) = nums(23) + 1;
                end
            end
            pause(1);
            %player_1
            if (testCase.ge.landlord == 1)
                up = 20;
            else
                up = 17;
            end
            for i = 1 : up
                k = testCase.player_1.cards{4,i};
                nums(k) = nums(k) + 1;
                if isequal(testCase.player_1.cards{2,i},'clubs')
                    nums(20) = nums(20) + 1;
                elseif isequal(testCase.player_1.cards{2,i},'hearts')
                    nums(21) = nums(21) + 1;
                elseif isequal(testCase.player_1.cards{2,i},'diamonds')
                    nums(22) = nums(22) + 1;
                elseif isequal(testCase.player_1.cards{2,i},'spades')
                    nums(23) = nums(23) + 1;
                end
            end 
            pause(1);
            %player_2
            if (testCase.ge.landlord == 2)
                up = 20;
            else
                up = 17;
            end
            for i = 1 : up
                k = testCase.player_2.cards{4,i};
                nums(k) = nums(k) + 1;
                if isequal(testCase.player_2.cards{2,i},'clubs')
                    nums(20) = nums(20) + 1;
                elseif isequal(testCase.player_2.cards{2,i},'hearts')
                    nums(21) = nums(21) + 1;
                elseif isequal(testCase.player_2.cards{2,i},'diamonds')
                    nums(22) = nums(22) + 1;
                elseif isequal(testCase.player_2.cards{2,i},'spades')
                    nums(23) = nums(23) + 1;
                end
            end 
            %check
            for i = 3:15
                testCase.verifyEqual(nums(i),4);
            end
            for i = 20:23
                testCase.verifyEqual(nums(i),13);
            end
            testCase.verifyEqual(nums(99),1);
            testCase.verifyEqual(nums(100),1);
            
            %T1.3.1
            if (testCase.ge.landlord == 0)
                testCase.verifyEqual(testCase.player_0.currUI.CardNum_currplayer.Text, '20');
                testCase.verifyEqual(testCase.player_1.currUI.CardNum_currplayer.Text, '17');
                testCase.verifyEqual(testCase.player_2.currUI.CardNum_currplayer.Text, '17');
                testCase.verifyEqual(testCase.player_0.currUI.CardNum_player_1.Text, '17');
                testCase.verifyEqual(testCase.player_1.currUI.CardNum_player_1.Text, '20');
                testCase.verifyEqual(testCase.player_2.currUI.CardNum_player_1.Text, '20');
                testCase.verifyEqual(testCase.player_0.currUI.CardNum_player_2.Text, '17');
                testCase.verifyEqual(testCase.player_1.currUI.CardNum_player_2.Text, '17');
                testCase.verifyEqual(testCase.player_2.currUI.CardNum_player_2.Text, '17');
            elseif (testCase.ge.landlord == 1)
                testCase.verifyEqual(testCase.player_0.currUI.CardNum_currplayer.Text, '17');
                testCase.verifyEqual(testCase.player_1.currUI.CardNum_currplayer.Text, '20');
                testCase.verifyEqual(testCase.player_2.currUI.CardNum_currplayer.Text, '17');
                testCase.verifyEqual(testCase.player_0.currUI.CardNum_player_1.Text, '20');
                testCase.verifyEqual(testCase.player_1.currUI.CardNum_player_1.Text, '17');
                testCase.verifyEqual(testCase.player_2.currUI.CardNum_player_1.Text, '20');
                testCase.verifyEqual(testCase.player_0.currUI.CardNum_player_2.Text, '17');
                testCase.verifyEqual(testCase.player_1.currUI.CardNum_player_2.Text, '17');
                testCase.verifyEqual(testCase.player_2.currUI.CardNum_player_2.Text, '17');
            elseif (testCase.ge.landlord == 2)
                testCase.verifyEqual(testCase.player_0.currUI.CardNum_currplayer.Text, '17');
                testCase.verifyEqual(testCase.player_1.currUI.CardNum_currplayer.Text, '17');
                testCase.verifyEqual(testCase.player_2.currUI.CardNum_currplayer.Text, '20');
                testCase.verifyEqual(testCase.player_0.currUI.CardNum_player_1.Text, '17');
                testCase.verifyEqual(testCase.player_1.currUI.CardNum_player_1.Text, '17');
                testCase.verifyEqual(testCase.player_2.currUI.CardNum_player_1.Text, '17');
                testCase.verifyEqual(testCase.player_0.currUI.CardNum_player_2.Text, '20');
                testCase.verifyEqual(testCase.player_1.currUI.CardNum_player_2.Text, '20');
                testCase.verifyEqual(testCase.player_2.currUI.CardNum_player_2.Text, '17');
            end
            
            %T1.4
                testCase.verifyEqual(testCase.ge.whoseTurn, testCase.ge.landlord);
                
        end
    end
end

