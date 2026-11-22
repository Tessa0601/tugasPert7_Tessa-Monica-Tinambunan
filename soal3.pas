program HasilStudiMahasiswa;

uses crt;

type
    // Record untuk menyimpan data mata kuliah.
    TMatkul = record
        namaMK : string;
        sks : integer;
        nilai : string;
        bobot : real;
        skor : real;
    end;

    // Record untuk menyimpan identitas mahasiswa
    // dan data mata kuliah yang diambil.
    TMahasiswa = record
        nama : string;
        nim : string;
        jumlahMK : integer;
        matkul : array[1..20] of TMatkul;
    end;

var
    // Array untuk menyimpan data mahasiswa.
    mahasiswa : array[1..100] of TMahasiswa;

    jumlahMhs : integer;
    i, j, k : integer;
    totalSKS : integer;
    totalSkor, ip : real;


// ======================================
// PROCEDURE INPUT DATA MAHASISWA
// ======================================

procedure InputData;
begin
    writeln('======================================');
    writeln('       INPUT HASIL STUDI MAHASISWA');
    writeln('======================================');

    write('Jumlah mahasiswa: ');
    readln(jumlahMhs);

    // For digunakan untuk mengulang input
    // sebanyak jumlah mahasiswa.
    for i := 1 to jumlahMhs do
    begin
        writeln;
        writeln('DATA MAHASISWA KE-', i);
        writeln('--------------------------------------');

        // Menginput identitas mahasiswa.
        write('Nama: ');
        readln(mahasiswa[i].nama);

        write('NIM: ');
        readln(mahasiswa[i].nim);

        // Menginput jumlah mata kuliah.
        write('Jumlah mata kuliah: ');
        readln(mahasiswa[i].jumlahMK);

        // For digunakan untuk menginput
        // mata kuliah setiap mahasiswa.
        for j := 1 to mahasiswa[i].jumlahMK do
        begin
            writeln;
            writeln('Mata Kuliah ke-', j);

            write('Nama mata kuliah: ');
            readln(mahasiswa[i].matkul[j].namaMK);

            write('Jumlah SKS: ');
            readln(mahasiswa[i].matkul[j].sks);

            write('Nilai: ');
            readln(mahasiswa[i].matkul[j].nilai);

            // If-Then-Else digunakan untuk menentukan
            // bobot berdasarkan nilai huruf.
            if mahasiswa[i].matkul[j].nilai = 'A' then
                mahasiswa[i].matkul[j].bobot := 4
            else if mahasiswa[i].matkul[j].nilai = 'B+' then
                mahasiswa[i].matkul[j].bobot := 3.5
            else if mahasiswa[i].matkul[j].nilai = 'B' then
                mahasiswa[i].matkul[j].bobot := 3
            else if mahasiswa[i].matkul[j].nilai = 'C+' then
                mahasiswa[i].matkul[j].bobot := 2.5
            else if mahasiswa[i].matkul[j].nilai = 'C' then
                mahasiswa[i].matkul[j].bobot := 2
            else if mahasiswa[i].matkul[j].nilai = 'D' then
                mahasiswa[i].matkul[j].bobot := 1
            else
                mahasiswa[i].matkul[j].bobot := 0;

            // Menghitung skor setiap mata kuliah.
            // Rumus: SKS dikali bobot nilai.
            mahasiswa[i].matkul[j].skor :=
                mahasiswa[i].matkul[j].sks *
                mahasiswa[i].matkul[j].bobot;

        end;
    end;
end;


// ======================================
// PROCEDURE MENAMPILKAN HASIL STUDI
// ======================================

procedure TampilData;
begin
    // For digunakan untuk menampilkan
    // data mahasiswa satu per satu.
    for i := 1 to jumlahMhs do
    begin
        clrscr;

        // Menginisialisasi total SKS dan total skor.
        totalSKS := 0;
        totalSkor := 0;

        // Menampilkan identitas mahasiswa.
        writeln;
        writeln('       Nama : ', mahasiswa[i].nama);
        writeln('       NIM  : ', mahasiswa[i].nim);

        writeln('       ---------------------------------------------------------------');

        // Menampilkan judul tabel.
        writeln('       | No | Mata Kuliah                  | SKS | Nilai | Skor      |');

        writeln('       ---------------------------------------------------------------');

        // For digunakan untuk menampilkan
        // seluruh mata kuliah mahasiswa.
        for j := 1 to mahasiswa[i].jumlahMK do
        begin

            // Menghitung jumlah seluruh SKS.
            totalSKS := totalSKS + mahasiswa[i].matkul[j].sks;

            // Menghitung total skor.
            totalSkor := totalSkor + mahasiswa[i].matkul[j].skor;

            // Menampilkan nomor dan nama mata kuliah.
            write('       | ', j:2, ' | ');

            write(mahasiswa[i].matkul[j].namaMK);

            // Menambahkan spasi agar kolom sejajar.
            for k := length(mahasiswa[i].matkul[j].namaMK) + 1 to 30 do
                write(' ');

            // Menampilkan SKS, nilai, dan skor.
            writeln(' | ', mahasiswa[i].matkul[j].sks:3,
                    ' | ', mahasiswa[i].matkul[j].nilai:5,
                    ' | ', mahasiswa[i].matkul[j].skor:6:1, ' |');

        end;

        writeln('       ---------------------------------------------------------------');

        // Menampilkan total skor mahasiswa.
        writeln('       | TOTAL                                          | ',
                totalSkor:6:1, ' |');

        writeln('       ---------------------------------------------------------------');

        // Menampilkan jumlah SKS.
        writeln('       Jumlah SKS : ', totalSKS);

        // Menghitung Indeks Prestasi (IP).
        // IP = Total Skor dibagi Jumlah SKS.
        if totalSKS > 0 then
        begin
            ip := totalSkor / totalSKS;
            writeln('       IP         : ', ip:0:2);
        end
        else
            writeln('       IP         : 0.00');

        writeln;
        writeln;

        // ReadKey digunakan untuk memberikan jeda
        // sebelum menampilkan mahasiswa berikutnya.
        if i < jumlahMhs then
        begin
            writeln('       Tekan sembarang tombol untuk melihat data');
            writeln('       selanjutnya..');
            readkey;
        end;

    end;
end;


// ======================================
// PROGRAM UTAMA
// ======================================

begin
    clrscr;

    // Memanggil procedure untuk input data.
    InputData;

    // Memanggil procedure untuk menampilkan hasil.
    TampilData;

    writeln;
    writeln('Seluruh data mahasiswa telah ditampilkan.');

    readln;
end.