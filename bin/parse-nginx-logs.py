import re
import sys

import pandas as pd

with open("logs.csv") as f:
    lines = f.read().split("\n")
    df = pd.DataFrame()
    for line in lines:
        if line:
            m = re.match(
                r'"(?P<remote_addr>.+) - '
                r"(?P<remote_user>.+) "
                r"\[(?P<time_local>.+)\] "
                r'""(?P<request>.+)"" '
                r"(?P<status>[0-9]*) "
                r"(?P<body_bytes_sent>[0-9]) "
                r'""(?P<http_referrer>.+)"" '
                r'""(?P<http_user_agent>.+)"" '
                r"(?P<request_time>[0-9\.]+) "
                r"(?P<upstream_response_time>[0-9\.]+) "
                r"(?P<pipe>.+) "
                r'""(?P<http_x_forwarded_for>.+)""',
                line,
            )
            if m:
                df.loc[len(df)] = m.groupdict()
    print(df)
