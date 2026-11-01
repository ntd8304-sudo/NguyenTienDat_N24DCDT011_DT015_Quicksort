using Test
include(joinpath(@__DIR__, "..", "src", "DeTai.jl"))
using .DeTai

"""
Hàm kiểm tra tính bất biến bảo toàn đa tập (multiset preservation):
Mảng sau sắp xếp phải chứa đúng các phần tử với cùng tần suất như mảng ban đầu.
"""
function kiem_tra_da_tap(goc::Vector{Int}, da_sap::Vector{Int})
    dem_goc = Dict{Int, Int}()
    dem_sap = Dict{Int, Int}()
    for x in goc
        dem_goc[x] = get(dem_goc, x, 0) + 1
    end
    for x in da_sap
        dem_sap[x] = get(dem_sap, x, 0) + 1
    end
    return dem_goc == dem_sap
end

@testset "Bộ kiểm thử đề tài DT015 - Quicksort và lần vết phân hoạch" begin

    @testset "A01: Ví dụ 1 trên phiếu - Dãy sách 8 phần tử" begin
        a = [6, 1, 7, 5, 3, 8, 2, 4]
        exp = [1, 2, 3, 4, 5, 6, 7, 8]
        act = giai_bai(copy(a); trace = false)
        @test act == exp
        @test issorted(act)
        @test kiem_tra_da_tap(a, act)
    end

    @testset "A02: Ví dụ 2 trên phiếu - Mảng có khóa trùng [2, 2, 1]" begin
        a = [2, 2, 1]
        exp = [1, 2, 2]
        act = giai_bai(copy(a); trace = false)
        @test act == exp
        @test issorted(act)
        @test kiem_tra_da_tap(a, act)
    end

    @testset "A03: Ca trên phiếu - Mảng đã sắp tăng sẵn" begin
        a = [1, 2, 3, 4]
        exp = [1, 2, 3, 4]
        act = giai_bai(copy(a); trace = false)
        @test act == exp
        @test issorted(act)
        @test kiem_tra_da_tap(a, act)
    end

    @testset "A04: Ca trên phiếu - Mảng giảm dần" begin
        a = [4, 3, 2, 1]
        exp = [1, 2, 3, 4]
        act = giai_bai(copy(a); trace = false)
        @test act == exp
        @test issorted(act)
        @test kiem_tra_da_tap(a, act)
    end

    @testset "A05: Ca biên - Mảng rỗng []" begin
        a = Int[]
        exp = Int[]
        act = giai_bai(copy(a); trace = false)
        @test act == exp
        @test length(act) == 0
    end

    @testset "A06: Ca biên - Mảng 1 phần tử [42]" begin
        a = [42]
        exp = [42]
        act = giai_bai(copy(a); trace = false)
        @test act == exp
        @test length(act) == 1
    end

    @testset "A07: Ca biên - Mảng toàn phần tử bằng nhau [2, 2, 2, 2, 2]" begin
        a = [2, 2, 2, 2, 2]
        exp = [2, 2, 2, 2, 2]
        act = giai_bai(copy(a); trace = false)
        @test act == exp
        @test issorted(act)
        @test kiem_tra_da_tap(a, act)
    end

    @testset "A08: Ca tự thiết kế - Mảng chứa cả số âm, số 0 và số dương" begin
        a = [-3, 7, -1, 0, 5, -8, 2]
        exp = [-8, -3, -1, 0, 2, 5, 7]
        act = giai_bai(copy(a); trace = false)
        @test act == exp
        @test issorted(act)
        @test kiem_tra_da_tap(a, act)
    end

    @testset "A09: Ca tự thiết kế - Mảng 2 phần tử nghịch thế [9, 1]" begin
        a = [9, 1]
        exp = [1, 9]
        act = giai_bai(copy(a); trace = false)
        @test act == exp
        @test issorted(act)
        @test kiem_tra_da_tap(a, act)
    end

    @testset "A10: Ca tự thiết kế - Mảng 2 phần tử đã có thứ tự [3, 7]" begin
        a = [3, 7]
        exp = [3, 7]
        act = giai_bai(copy(a); trace = false)
        @test act == exp
        @test issorted(act)
        @test kiem_tra_da_tap(a, act)
    end

    @testset "A11: Ca quy mô - Mảng 50 phần tử ngẫu nhiên kiểm nghiệm với sort chuẩn" begin
        a = [rand(-100:100) for _ in 1:50]
        exp = sort(a)
        act = giai_bai(copy(a); trace = false)
        @test act == exp
        @test issorted(act)
        @test kiem_tra_da_tap(a, act)
    end

    @testset "A12: Kiểm tra bất biến và trace - Hàm lan_vet_quick có thống kê" begin
        a = [6, 1, 7, 5, 3, 8, 2, 4]
        kq = lan_vet_quick(a; trace = true)
        @test kq.mang_da_sap == [1, 2, 3, 4, 5, 6, 7, 8]
        @test kq.thong_ke.so_so_sanh > 0
        @test kq.thong_ke.so_doi_cho > 0
        @test kq.thong_ke.do_sau_max >= 1
        @test length(kq.thong_ke.cac_buoc_trace) > 0
    end

    @testset "A13: Kiểm tra Validator - Ném ngoại lệ khi sai kiểu dữ liệu" begin
        @test_throws ArgumentError kiem_tra_dau_vao(["abc", "def"])
        @test_throws ArgumentError kiem_tra_dau_vao([1.5, 2.5, 3.5])
        @test_throws ArgumentError kiem_tra_dau_vao("khong_phai_vector")
    end

    @testset "A14: Kiểm tra Validator - Ném ngoại lệ khi kích thước n > 10000" begin
        mang_qua_tai = zeros(Int, 10001)
        @test_throws ArgumentError kiem_tra_dau_vao(mang_qua_tai)
    end

end
