function [x_best] = main_fun(times,Pm,Nums,WayOfcoding,WayofSelect,IsDraw,x)
    y=f(x);
    % 一、初始化
    % （1）随机产生四个个体
    x_random = randperm(16); % 将自变量随机进行排列
    x_father = x(x_random(1:4)); % 取前四个个体作为父体
    timesofmuta=0; % 记录变异次数
    % 二、开始迭代
    % fprintf("---开始迭代，迭代次数：%d，变异概率：%.4f，个体数目：%d\r",times,Pm,Nums);
    for i = 1:times
    %     fprintf("迭代次数：%d\r",i);
        % (1) 编码
        father_mat = encode(x_father,WayOfcoding);

        % (2) 交叉
        % --确定交叉端
        r_index=[2,3,4];
        r1 = r_index(randi(3)); 
        r2 = r_index(randi(3));

        % --交叉后的子代echild_mat
        child_mat = father_mat; 

        % --交换片段1
        ex_part = child_mat(1, r1:4);
        child_mat(1, r1:4) = child_mat(2, r1:4);
        child_mat(2, r1:4) = ex_part;

        % --交换片段2
        ex_part = child_mat(3, r2:4);
        child_mat(3, r2:4) = child_mat(4, r2:4);
        child_mat(4, r2:4) = ex_part;

        % (3) 变异 
        for i_muta = 1:4
            if rand()<Pm
                % ---变异位置
                timesofmuta = timesofmuta + 1;
                r_m_index=[1,2,3,4];
                r_m = r_m_index(randi(4));
                child_mat(i_muta, r_m) = ~child_mat(i_muta, r_m);
            end
        end

        % (4) 合并子代与父代 
        all_mat = [father_mat;child_mat]; % 垂直拼接
        % (5) 解码
        x_childs = decode(all_mat,WayOfcoding);

        % (6) 子代表现形
        y_childs = f(x_childs);

        % 绘图，当前待选择的全部点
        if IsDraw
            plot(x, y, 'LineWidth', 2);
            xlabel('x'); 
            ylabel('f(x)'); 
            title('Plot of f(x) = (x - 3)^2');
            for i_c_plot = 1:Nums*2
            plot(x_childs(i_c_plot), y_childs(i_c_plot), 'bo-', 'MarkerFaceColor', 'r'); 
            pause(0.01);
            end
        end

        % (7) 筛选
        if WayofSelect == 0 % 轮盘赌
            % 归一化
            P_d = 1./(y_childs+0.0001);
            P_Sum = sum(P_d, 'all');
            P_Child = P_d/P_Sum;

            % 计算累计密度
            Pf_Child = zeros(1,8);
            for pi = 1:8
                for pc = 1:pi
                    Pf_Child(pi) = Pf_Child(pi) + P_Child(pc);
                end
            end

            % 轮盘赌，选择下一批迭代个体
            for in = 1:4
                Pr = rand();
                for pif = 1:8
                    if Pf_Child(pif) >= Pr
                        x_father(in) = x_childs(pif);
                        break;
                    end
                end
            end

        elseif WayofSelect == 1 % 锦标赛
            % 子代，父代二选一
            for ij = 1:Nums
                if y_childs(ij) > y_childs(ij+Nums)
                    x_father(ij) = x_childs(ij+Nums);
                else
                    x_father(ij) = x_childs(ij);
                end
            end
        end

        if IsDraw
            % 绘制选择后的点
            for i_plot = 1:Nums
                plot(x_father(i_plot), f(x_father(i_plot)), 'bo-', 'MarkerFaceColor', 'b'); 
                pause(0.02);
            end
            cla;
        end

    end
%     fprintf("---结束迭代，变异次数：%d\r",timesofmuta);

    % 在最后一代中选择最优
    y_father = f(x_father);
    best_Yindex = y_father(1);
    best_Xindex = 1;
    for i_best = 1:Nums
        if y_father(i_best) < best_Yindex
            best_Yindex = y_father(i_best);
            best_Xindex = i_best;
        end
    end
    x_best = x_father(best_Xindex);
    % 绘制迭代结果
    if IsDraw
        plot(x, y, 'LineWidth', 2);
        xlabel('x'); 
        ylabel('f(x)'); 
        title('Plot of f(x) = (x - 3)^2');
        plot(x_best, f(x_best), 'y^--', 'MarkerFaceColor', 'm','MarkerSize',10);  
        hold on;
    end
    
end

