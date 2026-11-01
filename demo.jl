include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai

function in_tieu_de(str)
    println("\n" * "="^70)
    println("  " * str)
    println("="^70)
end

function chay_minh_hoa(ten_ca, a_input, expected)
    println("\n" * "-"^60)
    println("▶ $ten_ca")
    println("  • Dữ liệu vào (Input):    $a_input")
    println("  • Kết quả kỳ vọng:        $expected")

    ket_qua = lan_vet_quick(a_input; trace = true)
    actual = ket_qua.mang_da_sap
    tk = ket_qua.thong_ke

    println("  • Kết quả thực tế:        $actual")
    khop = (actual == expected) ? "✓ KHỚP (PASS)" : "✗ SAI (FAIL)"
    println("  • Đánh giá:               $khop")
    println("  • Thống kê:               Số so sánh = $(tk.so_so_sanh), Số đổi chỗ = $(tk.so_doi_cho), Độ sâu đệ quy = $(tk.do_sau_max)")

    println("  • Các bước lần vết (Trace):")
    for buoc in tk.cac_buoc_trace
        println("      $buoc")
    end
end

function main()
    println("╔════════════════════════════════════════════════════════════════════╗")
    println("║               BÁO CÁO ĐỒ ÁN MÔN HỌC INT13185 - NHÓM 03             ║")
    println("║  ĐỀ TÀI DT015: QUICKSORT VÀ LẦN VẾT PHÂN HOẠCH                      ║")
    println("║  Sinh viên thực hiện: NGUYỄN TIẾN ĐẠT - MSSV: N24DCDT011           ║")
    println("║  Giảng viên hướng dẫn: ThS. HỒ NHỰT MINH                           ║")
    println("╚════════════════════════════════════════════════════════════════════╝")

    in_tieu_de("PHẦN 1: CHẠY HAI VÍ DỤ TRÊN PHIẾU GIAO ĐỀ TÀI")
    chay_minh_hoa("VÍ DỤ 1 (Dãy 8 phần tử trong sách)", [6, 1, 7, 5, 3, 8, 2, 4], [1, 2, 3, 4, 5, 6, 7, 8])
    chay_minh_hoa("VÍ DỤ 2 (Mảng có khóa trùng, tăng i giảm j)", [2, 2, 1], [1, 2, 2])

    in_tieu_de("PHẦN 2: CHẠY NĂM CA KIỂM TRA BẮT BUỘC THEO PHIẾU")
    ca_test = [
        ("Ca 1: Dãy sách 8 phần tử ra 1..8", [6, 1, 7, 5, 3, 8, 2, 4], [1, 2, 3, 4, 5, 6, 7, 8]),
        ("Ca 2: [2, 2, 1] cho [1, 2, 2]", [2, 2, 1], [1, 2, 2]),
        ("Ca 3: [1, 2, 3, 4] giữ tăng", [1, 2, 3, 4], [1, 2, 3, 4]),
        ("Ca 4: [4, 3, 2, 1] ra tăng", [4, 3, 2, 1], [1, 2, 3, 4]),
        ("Ca 5: Mảng rỗng [] và mảng 1 phần tử [9]", Int[], Int[])
    ]

    for (ten, inp, exp) in ca_test
        chay_minh_hoa(ten, inp, exp)
    end

    # Kiểm tra thêm mảng 1 phần tử của Ca 5
    chay_minh_hoa("Ca 5b: Mảng một phần tử [9]", [9], [9])

    println("\n" * "="^70)
    println("  HOÀN THÀNH CHẠY CÁC VÍ DỤ VÀ CA KIỂM THỬ MẪU THÀNH CÔNG!")
    println("="^70)
end

main()
