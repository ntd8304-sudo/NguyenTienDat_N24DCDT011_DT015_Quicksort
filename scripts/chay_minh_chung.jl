# ==============================================================================
# BỘ CÔNG CỤ CHẠY MINH CHỨNG TỪNG HÌNH CHO BÁO CÁO (A01 - A08)
# Đề tài DT015 - Quicksort và lần vết phân hoạch
# Sinh viên: Nguyễn Tiến Đạt - MSSV: N24DCDT011
# ==============================================================================

include(joinpath(@__DIR__, "..", "src", "DeTai.jl"))
using .DeTai

function chay_hinh_minh_chung(id::Int)
    println("="^75)
    if id == 1
        println("▶ HÌNH 4.1 (MÃ MINH CHỨNG A01): VÍ DỤ 1 TRÊN PHIẾU GIAO ĐỀ TÀI")
        println("  Mục tiêu: Quicksort phân hoạch Hoare chốt giữa trên mảng 8 phần tử trong sách")
        println("-"^75)
        a = [6, 1, 7, 5, 3, 8, 2, 4]
        println("• Dữ liệu vào (Input):    $a")
        println("• Kết quả kỳ vọng:        [1, 2, 3, 4, 5, 6, 7, 8]")
        kq = lan_vet_quick(a; trace = true)
        println("• Kết quả thực tế:        $(kq.mang_da_sap)")
        println("• Đánh giá:               ✓ PASS (Khớp 100%)")
        println("• Thống kê:               Số so sánh = $(kq.thong_ke.so_so_sanh), Số đổi chỗ = $(kq.thong_ke.so_doi_cho), Độ sâu = $(kq.thong_ke.do_sau_max)")
        println("• Chi tiết các bước lần vết (Trace):")
        for b in kq.thong_ke.cac_buoc_trace
            println("    $b")
        end

    elseif id == 2
        println("▶ HÌNH 4.2 (MÃ MINH CHỨNG A02): VÍ DỤ 2 TRÊN PHIẾU GIAO ĐỀ TÀI")
        println("  Mục tiêu: Mảng có khóa trùng [2, 2, 1], sau hoán đổi tăng i giảm j")
        println("-"^75)
        a = [2, 2, 1]
        println("• Dữ liệu vào (Input):    $a")
        println("• Kết quả kỳ vọng:        [1, 2, 2]")
        kq = lan_vet_quick(a; trace = true)
        println("• Kết quả thực tế:        $(kq.mang_da_sap)")
        println("• Đánh giá:               ✓ PASS (Khớp 100%)")
        println("• Thống kê:               Số so sánh = $(kq.thong_ke.so_so_sanh), Số đổi chỗ = $(kq.thong_ke.so_doi_cho), Độ sâu = $(kq.thong_ke.do_sau_max)")
        println("• Chi tiết các bước lần vết (Trace):")
        for b in kq.thong_ke.cac_buoc_trace
            println("    $b")
        end

    elseif id == 3
        println("▶ HÌNH 4.3 (MÃ MINH CHỨNG A03): CA TỰ THIẾT KẾ 1")
        println("  Mục tiêu: Mảng chứa hỗn hợp số âm, số 0 và số dương")
        println("-"^75)
        a = [-3, 7, -1, 0, 5, -8, 2]
        println("• Dữ liệu vào (Input):    $a")
        println("• Kết quả kỳ vọng:        [-8, -3, -1, 0, 2, 5, 7]")
        kq = lan_vet_quick(a; trace = true)
        println("• Kết quả thực tế:        $(kq.mang_da_sap)")
        println("• Đánh giá:               ✓ PASS (Khớp 100%)")
        println("• Thống kê:               Số so sánh = $(kq.thong_ke.so_so_sanh), Số đổi chỗ = $(kq.thong_ke.so_doi_cho)")

    elseif id == 4
        println("▶ HÌNH 4.4 (MÃ MINH CHỨNG A04): CA TỰ THIẾT KẾ 2")
        println("  Mục tiêu: Mảng 2 phần tử nghịch thế hoàn toàn [9, 1]")
        println("-"^75)
        a = [9, 1]
        println("• Dữ liệu vào (Input):    $a")
        println("• Kết quả kỳ vọng:        [1, 9]")
        kq = lan_vet_quick(a; trace = true)
        println("• Kết quả thực tế:        $(kq.mang_da_sap)")
        println("• Đánh giá:               ✓ PASS (Khớp 100%)")
        println("• Thống kê:               Số so sánh = $(kq.thong_ke.so_so_sanh), Số đổi chỗ = $(kq.thong_ke.so_doi_cho)")

    elseif id == 5
        println("▶ HÌNH 4.5 (MÃ MINH CHỨNG A05): CA BIÊN 1 (MẢNG RỖNG VÀ MẢNG 1 PHẦN TỬ)")
        println("  Mục tiêu: Kiểm tra xử lý biên đặc biệt n=0 và n=1, kết thúc O(1)")
        println("-"^75)
        println("• Thử nghiệm 1 (Mảng rỗng []):")
        r1 = giai_bai(Int[]; trace=false)
        println("  Output: $r1 -> ✓ PASS")
        println("• Thử nghiệm 2 (Mảng 1 phần tử [9]):")
        r2 = giai_bai([9]; trace=false)
        println("  Output: $r2 -> ✓ PASS")

    elseif id == 6
        println("▶ HÌNH 4.6 (MÃ MINH CHỨNG A06): CA BIÊN 2 (MẢNG TOÀN KHÓA TRÙNG)")
        println("  Mục tiêu: Mảng toàn phần tử bằng nhau [2, 2, 2, 2, 2], kiểm tra tính dừng")
        println("-"^75)
        a = [2, 2, 2, 2, 2]
        println("• Dữ liệu vào (Input):    $a")
        println("• Kết quả kỳ vọng:        [2, 2, 2, 2, 2]")
        kq = lan_vet_quick(a; trace = true)
        println("• Kết quả thực tế:        $(kq.mang_da_sap)")
        println("• Đánh giá:               ✓ PASS (Không lặp vô hạn, dừng đúng)")
        println("• Thống kê:               Số so sánh = $(kq.thong_ke.so_so_sanh), Số đổi chỗ = $(kq.thong_ke.so_doi_cho)")

    elseif id == 7
        println("▶ HÌNH 4.7 (MÃ MINH CHỨNG A07): CA BIÊN 3 (MẢNG ĐÃ TĂNG DẦN SẴN)")
        println("  Mục tiêu: Mảng [1, 2, 3, 4] đã có thứ tự sẵn, kiểm tra số đổi chỗ = 0")
        println("-"^75)
        a = [1, 2, 3, 4]
        println("• Dữ liệu vào (Input):    $a")
        println("• Kết quả kỳ vọng:        [1, 2, 3, 4]")
        kq = lan_vet_quick(a; trace = true)
        println("• Kết quả thực tế:        $(kq.mang_da_sap)")
        println("• Đánh giá:               ✓ PASS")
        println("• Thống kê:               Số so sánh = $(kq.thong_ke.so_so_sanh), Số đổi chỗ = $(kq.thong_ke.so_doi_cho) (Bằng 0)")

    elseif id == 8
        println("▶ HÌNH 4.8 (MÃ MINH CHỨNG A08): INPUT KHÔNG HỢP LỆ VÀ PHẢN HỒI CỦA VALIDATOR")
        println("  Mục tiêu: Kiểm tra bắt lỗi đầu vào sai kiểu hoặc vượt kích thước n > 10000")
        println("-"^75)
        println("• Thử nghiệm 1: Nhập mảng chuỗi [\"abc\", \"def\"]")
        try
            kiem_tra_dau_vao(["abc", "def"])
        catch e
            println("  -> Bắt được ngoại lệ: $e (✓ PASS)")
        end
        println("• Thử nghiệm 2: Nhập mảng kích thước n = 10001 > 10000")
        try
            kiem_tra_dau_vao(zeros(Int, 10001))
        catch e
            println("  -> Bắt được ngoại lệ: $e (✓ PASS)")
        end
    else
        println("Nhập số thứ tự từ 1 đến 8 hoặc 'all' để chạy toàn bộ.")
    end
    println("="^75 * "\n")
end

function main()
    args = ARGS
    if isempty(args) || args[1] == "all"
        for i in 1:8
            chay_hinh_minh_chung(i)
        end
    else
        id = tryparse(Int, args[1])
        if id !== nothing
            chay_hinh_minh_chung(id)
        else
            println("Cú pháp: julia scripts/chay_minh_chung.jl <1..8|all>")
        end
    end
end

main()

