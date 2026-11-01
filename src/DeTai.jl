module DeTai

export kiem_tra_dau_vao, phan_hoach!, quick_sort!, lan_vet_quick, giai_bai
export ThongKeQuickSort

"""
    ThongKeQuickSort

Cấu trúc lưu trữ thống kê quá trình sắp xếp Quicksort:
- `so_so_sanh`: Tổng số phép so sánh khóa phần tử với chốt.
- `so_doi_cho`: Tổng số lần thực hiện hoán đổi hai phần tử thực sự (i < j).
- `do_sau_max`: Chiều sâu ngăn xếp gọi đệ quy lớn nhất đạt được.
- `cac_buoc_trace`: Danh sách chuỗi ghi lại toàn bộ nhật ký lần vết phân hoạch.
- `in_trace`: Cờ bật/tắt ghi vết (giúp tối ưu hiệu năng khi khảo sát mảng lớn).
"""
mutable struct ThongKeQuickSort
    so_so_sanh::Int
    so_doi_cho::Int
    do_sau_max::Int
    cac_buoc_trace::Vector{String}
    in_trace::Bool
end

ThongKeQuickSort(; in_trace::Bool = true) = ThongKeQuickSort(0, 0, 0, String[], in_trace)

"""
    kiem_tra_dau_vao(du_lieu)

Kiểm tra hợp đồng dữ liệu đầu vào theo đúng phiếu giao đề tài DT015:
- Dữ liệu phải là kiểu Vector chứa các số nguyên (`AbstractVector{<:Integer}`).
- Kích thước mảng: 0 <= n <= 10000.
Trả về `true` nếu hợp lệ, ngược lại ném ngoại lệ `ArgumentError`.
"""
function kiem_tra_dau_vao(du_lieu)
    if !(du_lieu isa AbstractVector{<:Integer})
        throw(ArgumentError("Dữ liệu đầu vào không hợp lệ: phải là mảng một chiều (Vector) chứa các số nguyên."))
    end
    n = length(du_lieu)
    if n > 10000
        throw(ArgumentError("Kích thước mảng vượt quá giới hạn cho phép: n = $n > 10000."))
    end
    return true
end

"""
    phan_hoach!(a::Vector{Int}, l::Int, r::Int, tk::ThongKeQuickSort, muc::Int)

Phân hoạch đoạn a[l..r] theo sơ đồ hai con trỏ của Hoare với chốt ở giữa đoạn:
- Chốt lấy giá trị: chot = a[(l + r) ÷ 2].
- Con trỏ i quét từ l sang phải (khi a[i] < chot), j quét từ r sang trái (khi a[j] > chot).
- Khi i <= j: nếu i < j thì hoán đổi a[i] và a[j]; sau đó bắt buộc tăng i, giảm j (tránh lặp vô hạn).
- Trả về cặp chỉ số (j, i) để phân chia hai đoạn con [l..j] và [i..r].
"""
function phan_hoach!(a::Vector{Int}, l::Int, r::Int, tk::ThongKeQuickSort, muc::Int)
    mid = (l + r) ÷ 2
    chot = a[mid]
    i, j = l, r

    if tk.in_trace
        push!(tk.cac_buoc_trace, "Mức $muc - Đoạn [$l..$r]: chọn chốt a[$mid] = $chot (i=$l, j=$r)")
    end

    while i <= j
        # Tìm phần tử bên trái không nhỏ hơn chốt
        while true
            tk.so_so_sanh += 1
            if a[i] < chot
                i += 1
            else
                break
            end
        end

        # Tìm phần tử bên phải không lớn hơn chốt
        while true
            tk.so_so_sanh += 1
            if a[j] > chot
                j -= 1
            else
                break
            end
        end

        if i <= j
            if i < j
                tk.so_doi_cho += 1
                if tk.in_trace
                    push!(tk.cac_buoc_trace, "  -> Đổi chỗ a[$i]=$(a[i]) <-> a[$j]=$(a[j])")
                end
                a[i], a[j] = a[j], a[i]
            elseif tk.in_trace
                push!(tk.cac_buoc_trace, "  -> Gặp khóa trùng nhau tại i == j = $i (không cần đổi chỗ)")
            end
            i += 1
            j -= 1
        end
    end

    if tk.in_trace
        push!(tk.cac_buoc_trace, "  => Kết thúc phân hoạch: i = $i, j = $j. Đoạn con: [$l..$j] và [$i..$r]")
    end

    return (j, i)
end

"""
    quick_sort_de_quy!(a::Vector{Int}, l::Int, r::Int, tk::ThongKeQuickSort, muc::Int)

Hàm đệ quy Quicksort:
- Cập nhật chiều sâu đệ quy lớn nhất.
- Phân hoạch đoạn a[l..r] thành hai đoạn độc lập [l..j] và [i..r].
- Chỉ gọi tiếp đệ quy trên đoạn có ít nhất 2 phần tử (l < j và i < r).
"""
function quick_sort_de_quy!(a::Vector{Int}, l::Int, r::Int, tk::ThongKeQuickSort, muc::Int)
    if muc > tk.do_sau_max
        tk.do_sau_max = muc
    end

    # Đoạn rỗng hoặc 1 phần tử thì dừng ngay
    l >= r && return

    j, i = phan_hoach!(a, l, r, tk, muc)

    # Đệ quy đoạn trái nếu có ít nhất 2 phần tử
    if l < j
        quick_sort_de_quy!(a, l, j, tk, muc + 1)
    end

    # Đệ quy đoạn phải nếu có ít nhất 2 phần tử
    if i < r
        quick_sort_de_quy!(a, i, r, tk, muc + 1)
    end
end

"""
    quick_sort!(a::Vector{Int}; trace::Bool = true)

Hàm sắp xếp Quicksort trực tiếp trên mảng `a` (sắp xếp tại chỗ).
Trả về thống kê `ThongKeQuickSort`.
"""
function quick_sort!(a::Vector{Int}; trace::Bool = true)
    kiem_tra_dau_vao(a)
    tk = ThongKeQuickSort(in_trace = trace)
    if length(a) >= 2
        quick_sort_de_quy!(a, 1, length(a), tk, 0)
    end
    return tk
end

"""
    lan_vet_quick(a::AbstractVector{<:Integer}; trace::Bool = true)

Hàm thực hiện sắp xếp nhanh và trả về bộ kết quả đầy đủ:
- `mang_goc`: Bản sao mảng ban đầu
- `mang_da_sap`: Mảng sau khi đã sắp xếp tăng dần
- `thong_ke`: Thống kê số so sánh, đổi chỗ, độ sâu, trace
"""
function lan_vet_quick(a::AbstractVector{<:Integer}; trace::Bool = true)
    kiem_tra_dau_vao(a)
    a_goc = copy(a)
    a_sap = copy(a)
    tk = quick_sort!(a_sap; trace = trace)
    return (
        mang_goc = a_goc,
        mang_da_sap = a_sap,
        thong_ke = tk
    )
end

"""
    giai_bai(du_lieu; trace::Bool = true)

Hàm chuẩn giao tiếp với khung bài làm của sinh viên:
Nhận vào `du_lieu`, kiểm tra hợp lệ, thực hiện sắp xếp và trả về kết quả mảng đã sắp xếp.
"""
function giai_bai(du_lieu; trace::Bool = true)
    ket_qua = lan_vet_quick(du_lieu; trace = trace)
    return ket_qua.mang_da_sap
end

end # module DeTai
