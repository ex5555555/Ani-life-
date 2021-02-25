package tw.iii.model;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.springframework.stereotype.Component;

@Embeddable
@Component
public class TradingDetailpk implements Serializable{
	private static final long serialVersionUID = 1L;

	@Column(name = "item")
	private Integer item;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id")
	private TradingRecord tradingRecord;
	
	
	public TradingDetailpk() {
	}


	public TradingDetailpk(Integer item, TradingRecord tradingRecord) {
		super();
		this.item = item;
		this.tradingRecord = tradingRecord;
	}


	public Integer getItem() {
		return item;
	}


	public void setItem(Integer item) {
		this.item = item;
	}


	public TradingRecord getTradingRecord() {
		return tradingRecord;
	}


	public void setTradingRecord(TradingRecord tradingRecord) {
		this.tradingRecord = tradingRecord;
	}




	@Override
	public boolean equals(Object obj) {
		if(this==obj)return true;
		if(!(obj instanceof TradingDetailpk))return false;
		TradingDetailpk that =(TradingDetailpk) obj;
		
		return(Objects.equals(tradingRecord.getid(), that.tradingRecord.getid())&&
				Objects.equals(getItem(),that.getItem()));
		
	}

	@Override
	public int hashCode() {
		final int prime =31;
		int result =1;
		result =prime*result+((item==null)?0:item.hashCode());
		result =prime*result+((tradingRecord==null)?0:tradingRecord.hashCode());
		
		return result;
	}
}
