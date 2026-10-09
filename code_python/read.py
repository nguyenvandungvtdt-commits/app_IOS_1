# import pandas as pd
# import json

# # 1. Đọc file Excel hoặc CSV
# file_path = 'data.xlsx'

# try:
#     df = pd.read_excel(file_path)
# except Exception:
#     df = pd.read_csv('data.csv')

# # Lọc và làm sạch dữ liệu
# df = df[['Building', 'Floor', 'RoomType', 'HardwareIndex']].dropna()

# # 2. Tối ưu dữ liệu sang dạng Mảng Dẹt (Flat Array)
# # Cấu trúc mỗi phần tử: [Tòa nhà, Tầng, Loại phòng, Chỉ số LED]
# flat_data = {
#     "p": "Dự Án Sa Bàn Tòa Nhà",  # p = project_name
#     "d": []                        # d = data
# }

# for _, row in df.iterrows():
#     flat_data["d"].append([
#         str(row['Building']).strip(),
#         str(row['Floor']).strip(),
#         int(row['RoomType']),
#         int(row['HardwareIndex'])
#     ])

# # 3. Xuất file JSON tối ưu dung lượng (loại bỏ space/indent)
# with open('config.json', 'w', encoding='utf-8') as f:
#     json.dump(flat_data, f, ensure_ascii=False, separators=(',', ':'))

# print(f"Đã xuất file config.json thành công! Tổng số bản ghi: {len(flat_data['d'])}")

import pandas as pd
import json

# 1. Đọc file Excel hoặc CSV
file_path = 'data1.xlsx'

try:
    df = pd.read_excel(file_path)
except Exception:
    df = pd.read_csv('data1.csv')

# Lọc các cột cần thiết
df = df[['Building', 'Floor', 'Room', 'RoomType', 'HardwareIndex']].dropna()

# 2. Đưa vào mảng dẹt 5 phần tử: [Tòa, Tầng, Số phòng, Loại phòng, Chỉ số LED]
flat_data = {
    "p": "Dự Án Sa Bàn Tòa Nhà",
    "d": []
}

for _, row in df.iterrows():
    flat_data["d"].append([
        str(row['Building']).strip(),
        str(row['Floor']).strip(),
        str(row['Room']).strip(),       # Thêm tên/số phòng
        int(row['RoomType']),
        int(row['HardwareIndex'])
    ])

# 3. Xuất ra file config.json tối ưu
with open('config.json', 'w', encoding='utf-8') as f:
    json.dump(flat_data, f, ensure_ascii=False, separators=(',', ':'))

print(f"Thành công! Đã tạo file config.json với {len(flat_data['d'])} phòng.")