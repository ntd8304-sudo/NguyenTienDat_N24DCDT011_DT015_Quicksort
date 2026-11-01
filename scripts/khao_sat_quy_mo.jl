include(joinpath(@__DIR__, "..", "src", "DeTai.jl"))
using .DeTai
using Random
using Printf

function chay_khao_sat(n::Int, loai::Symbol)
    Random.seed!(42)
    a = if loai == :ngau_nhien
        rand(-10000:10000, n)
    elseif loai == :tang_dan
        collect(1:n)
    elseif loai == :giam_dan
        collect(n:-1:1)
    elseif loai == :toan_trung
        fill(42, n)
    end

    # Đo thời gian và số phép toán (tắt trace màn hình để đo thời gian thuật toán thực tế)
    a_test = copy(a)
    t_start = time_ns()
    tk = quick_sort!(a_test; trace = false)
    t_elapsed_ms = (time_ns() - t_start) / 1e6

    return (n = n, loai = loai, tg_ms = t_elapsed_ms, so_so_sanh = tk.so_so_sanh, so_doi_cho = tk.so_doi_cho, do_sau = tk.do_sau_max)
end

function main()
    println("="^85)
    println("           BẢNG KHẢO SÁT HIỆU NĂNG THỰC NGHIỆM QUICKSORT (DT015)")
    println("="^85)
    @printf("%-6s | %-15s | %-12s | %-15s | %-12s | %-10s\n", "n", "Loại dữ liệu", "Thời gian(ms)", "Số phép so sánh", "Số đổi chỗ", "Độ sâu đệ quy")
    println("-"^85)

    quy_mo = [8, 50, 500, 5000]
    cac_loai = [
        (:ngau_nhien, "Ngẫu nhiên"),
        (:tang_dan, "Tăng dần"),
        (:giam_dan, "Giảm dần"),
        (:toan_trung, "Toàn trùng")
    ]

    for n in quy_mo
        for (loai_sym, loai_ten) in cac_loai
            kq = chay_khao_sat(n, loai_sym)
            @printf("%-6d | %-15s | %-12.4f | %-15d | %-12d | %-10d\n", kq.n, loai_ten, kq.tg_ms, kq.so_so_sanh, kq.so_doi_cho, kq.do_sau)
        end
        println("-"^85)
    end
end

main()
