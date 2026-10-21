x_kk = out.x_kk_EKF.Data;
P_kk = out.P_kk_EKF.Data;
x_next = out.x_next_EKF.Data;
P_next = out.P_next_EKF.Data;
F_k = out.F_k_EKF.Data;

x_smoothed(size(x_kk,1),:) = x_kk(size(x_kk,1),:);
P_smoothed(size(x_kk,1),:,:) = P_kk(:, :, size(x_kk,1));

%Smoother execution
% %recursive in reverse order
% x_next = x_next(:,:,70001);

for k = size(x_kk,1)-1:-1:1

    %Ck = P_k|k * F_k+1' * P_k+1|k^(-1)
    Ck = P_kk(:,:,k) * F_k(:,:,k+1)' / P_next(:,:,k+1);

    %x_k|n = x_k|k + Ck*(x_k+1|n - x_k+1|k)
	x_smoothed(k,:) = x_kk(k,:)' + Ck*(x_smoothed(k+1,:)' - x_next(:,:,k+1));

    %P_k|n = P_k|k + Ck*(P_k+1|n - P_k+1|k)*Ck'
    P_smoothed(k,:,:) = P_kk(:,:,k) + Ck*(P_smoothed(k+1,:,1) - P_next(:,:,k+1))*Ck';
end